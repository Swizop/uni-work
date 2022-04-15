
from http import server
import os
import socket
import sys
import util
import threading

packetsSet = set()
clientSocket = None
packetsDict = dict()
# done = False

def send_packets(packetsNeeded, f, serverTuple):
    global packetsSet, clientSocket, packetsDict
    for i in range(packetsNeeded):
        video = f.read(2)        # citim 2 bytes din fisier
        packet = util.set_tudp_header(0, util.PSH, video.decode('utf-8'))
        clientSocket.sendto(packet, serverTuple)
        packetsSet.add(util.seqq + 1)       # ack number-ul asteptat
        packetsDict[util.seqq + 1] = packet
    return
    
def received_packets(clientSocket):
    global packetsSet
    while True:
        try:
            data = clientSocket.recvfrom(4096)[0]
            seq, ack, flags, data = util.get_info_tudp_header(data)
            if flags == util.ACK and seq in packetsSet:
                packetsSet.remove(seq)
        except:
            # timeout
            return



serverTuple = ('127.0.0.1', 55555)
try:
    clientSocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    clientSocket.settimeout(10)     # nu poate astepta mai mult de 10s la un recv
    print("Client started")

except socket.error as err:
    print(f"Error. Reason {str(err)}")
    sys.exit()

clientSocket.sendto(util.set_tudp_header(-1, util.SYN), serverTuple)
print("se asteapta un raspuns")

try:
    data = clientSocket.recvfrom(4096)[0]
    seq, ack, flags, data = util.get_info_tudp_header(data)
    print(f"Primit mesaj de la server. Seq: {seq} Ack: {ack} Flags: {flags} Data: {data}")
except:
    print("timeout")

if flags == util.SYNACK:
    # trimitem ack si incepem transferul de pachete.
    clientSocket.sendto(util.set_tudp_header(0, util.ACK), serverTuple)

    dimensiune = os.path.getsize("in.txt")
    print(f"3-way handshake incheiat. Trimitem un fisier de dimensiune {dimensiune}")


    f = open("in.txt", "rb")     # deschidem in format de bytes
    packetsNeeded = dimensiune // 2 + 1      # cate pachete va trb sa trimitem 
    # if dimensiune % 2 != 0:
    #     dimensiune += 1
    
    t1 = threading.Thread(target=send_packets, args=(packetsNeeded, f, serverTuple))
    t2 = threading.Thread(target=received_packets, args=(clientSocket,))
    t1.start()
    t2.start()
    t1.join()
    t2.join()

    if len(packetsSet) > 0:
        print(f"Se retrimite. S-au pierdut: {packetsSet}")
        for ackNumber in packetsSet:
            clientSocket.sendto(packetsDict[ackNumber], serverTuple)
            data = clientSocket.recvfrom(4096)[0]
            seq, ack, flags, data = util.get_info_tudp_header(data)
            if flags != util.ACK:
                print("Transfer esuat")
                sys.exit()

    print("sending FIN")
    clientSocket.sendto(util.set_tudp_header(0, util.FIN), serverTuple)
    data = clientSocket.recvfrom(4096)[0]
    _, _, flags, _ = util.get_info_tudp_header(data)
    if flags == util.ACK:
        data = clientSocket.recvfrom(4096)[0]
        _, _, flags, _ = util.get_info_tudp_header(data)
        if flags == util.FIN:
            clientSocket.sendto(util.set_tudp_header(0, util.ACK), serverTuple)
    
    print("Transmisiune incheiata prin 4-way handshake.")


    
        
    

