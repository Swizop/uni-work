# base code: https://github.com/senisioi/computer-networks/blob/2022/capitolul2/src/tcp_client.py

# TCP client
import socket
import logging
import time
import sys
import os

logging.basicConfig(format = u'[LINE:%(lineno)d]# %(levelname)-8s [%(asctime)s]  %(message)s', level = logging.NOTSET)

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM, proto=socket.IPPROTO_TCP)

port = 10000
adresa = '10.0.2.15'
server_address = (adresa, port)

f = open("poza_client.png", 'rb')
dimPoza = os.path.getsize("poza_client.png")
poza = f.read(dimPoza)

try:
    logging.info('Handshake cu %s', str(server_address))
    sock.connect(server_address)
    time.sleep(3)
    sock.sendall(poza)
    data = sock.recv(1024)
    if len(data) > 0:
        logging.info('Content primit: "%s"', data)

finally:
    logging.info('closing socket')
    f.close()
    sock.close()