import socket
import sys

# # 1. create tcp socket

# try:
#     # 90% of sockets on the internet are AF_INET. there is also unix inet
#     # type sock_stream for TCP. UDP -> sock_dgram
#     s = socket.socket(family=socket.AF_INET, type=socket.SOCK_STREAM)
# except socket.error as er:
#     print(f"Error. Reason {str(er)}")
#     sys.exit()

# print("Socket created")
# target_host = input("target_host: ")
# target_port = input("target_port: ")
# try:
#     s.connect((target_host, int(target_port)))
#     print("socket connected")
#     s.shutdown(2)
# except socket.error as er:
#     print(er)
#     sys.exit()



# # 2. server socket
# server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# # a server must first bind the socket to a specific IP and port, so it can listen to incoming requests
# # 127.0.0.1 -> localhost
# server_socket.bind(('127.0.0.1', 12345))
# server_socket.listen(5)     # maximum 5 sockets can connect

# try:
#     while True:
#         print("Waiting for connection")
#         client_socket, addr = server_socket.accept()    # the object will go into the first, and the addres in addr
#         print("client connected from", addr)
#         while True:
#             data = client_socket.recv(1024)     # you can receive between 1 and 1024 bytes through this method
#             if not data or data.decode('utf-8') == 'END':   # if we no longer receive data
#                 break
#             print(f"received from client {data.decode('utf-8')}")
            
#             # send data to client
#             try:    
#                 client_socket.send(bytes('Hey client', 'utf-8'))
#             except KeyboardInterrupt:
#                 print('user exit')
#         client_socket.close()
# except KeyboardInterrupt:
#     server_socket.close()



# 3. udp server
# no more listening and accepting connections

# dgram for UDP
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind(('127.0.0.1', 12345))

while True:
    data, addr = sock.recvfrom(4096)        # receive 4096 bytes. recvfrom bc, in tcp, the sender never changed. here, it might
    print(str(data))
    message = bytes("Hello from UDP srv", encoding='UTF-8')
    sock.sendto(message, addr)