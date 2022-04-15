# serverIpv4, serverPort, timeOut, fragmentSize, windowSize, file = "127.0.0.1", 55535, 20, 500, 10, "shark.jpg"
# clients = dict()

import util
import socket
import sys

try:
    serverSocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    serverSocket.bind(('127.0.0.1', 55555))
    serverSocket.settimeout(50)
    print("Server started")
except socket.error as err:
    print(f"Error. Reason {str(err)}")
    sys.exit()

clienti = []

def set_tudp_header(seq, flags, data = ''):
    return bytes(util.to_bytes(seq) + util.to_bytes(seq + 1) + flags + '000' + data, encoding="UTF-8")

while True:
    try:
        print("Se asteapta")
        data, addr = serverSocket.recvfrom(4096)
        seq, ack, flags, data = util.get_info_tudp_header(data)
        print(f"Primit mesaj de la {addr[0]}:{addr[1]}. Seq: {seq} Ack: {ack} Flags: {flags} Data: {data}")
        
        if flags == util.SYN:
            clienti.append(addr)
            serverSocket.sendto(util.set_tudp_header(0, util.SYNACK), addr)
            
            data, addr = serverSocket.recvfrom(4096)
            seq, ack, flags, data = util.get_info_tudp_header(data)
            if flags == util.ACK and addr == clienti[-1]:
                print(f"Conexiune RUDP realizata cu {addr[0]}:{addr[1]}. Se asteapta fisierul")

                
                buffer = []
                i = 0
                try:
                    while True:
                        data, addr = serverSocket.recvfrom(4096)
                        seq, ack, flags, data = util.get_info_tudp_header(data)
                        print(flags)
                        if addr in clienti:
                            # print(flags)
                            if flags == util.FIN:
                                break
                            if flags == util.PSH:
                                if i % 4 == 0:
                                    i += 1
                                    continue
                                buffer.append((seq, data))
                                serverSocket.sendto(set_tudp_header(seq + 1, util.ACK), addr)
                        i += 1
                except socket.error as err:
                    print("Eroare!")
                    print(err)
                    sys.exit()
                    continue
                
                serverSocket.sendto(util.set_tudp_header(0, util.ACK), addr)
                serverSocket.sendto(util.set_tudp_header(0, util.FIN), addr)
                data, addr = serverSocket.recvfrom(4096)
                _, _, flags, _ = util.get_info_tudp_header(data)
                if addr in clienti and flags == util.ACK:
                    print("Transfer terminat")
                    g = open("out.txt", 'wb')
                    # buffer.sort(key=lambda t: t[0])
                    for (_, d) in buffer:
                        g.write(bytes(d, encoding="utf-8"))
                    g.close()
                    sys.exit()


    except KeyboardInterrupt:
        print("Program stopping")
        serverSocket.close()
        sys.exit()
