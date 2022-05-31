# base code: https://github.com/senisioi/computer-networks/blob/2022/capitolul2/src/tcp_server.py

# TCP Server
import socket
import logging
import time

logging.basicConfig(format = u'[LINE:%(lineno)d]# %(levelname)-8s [%(asctime)s]  %(message)s', level = logging.NOTSET)

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM, proto=socket.IPPROTO_TCP)

port = 10000
adresa = '10.0.2.15'
server_address = (adresa, port)
sock.bind(server_address)
logging.info("Serverul a pornit pe %s si portnul portul %d", adresa, port)
sock.listen(5)
try:
    while True:
        logging.info('Asteptam conexiui...')
        conexiune, address = sock.accept()
        logging.info("Handshake cu %s", address)
        time.sleep(2)

        g = open("received.png", 'wb')
        fragment = conexiune.recv(1024)
        logging.info('Content primit: "%s"', fragment)
        conexiune.send(b"Server a primit mesajul: " + fragment)
        poza = fragment
        try:
            while True:
                fragment = conexiune.recv(1024)
                poza += fragment
        except ConnectionResetError:
            g.write(poza)
            g.close()
            conexiune.close()
finally:
    sock.close()