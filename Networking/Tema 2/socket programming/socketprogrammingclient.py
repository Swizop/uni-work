import socket
# # tcp client
# client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# client_socket.connect(('127.0.0.1', 12345))
# payload = 'Hey server'

# try:
#     while True:
#         client_socket.send(payload.encode('UTF-8'))
#         data = client_socket.recv(1024)
#         print(str(data))
#         break
# except KeyboardInterrupt:
#     print("user exit")
# client_socket.close()


# udp client
client_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

msg = "Hello UDP server"
client_socket.sendto(msg.encode('utf-8'), ('127.0.0.1', 12345))
data, addr = client_socket.recvfrom(4096)
print("server says")
print(str(data))
client_socket.close()