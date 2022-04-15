import random

SYN = '10000'
ACK = '01000'
SYNACK = '11000'
NACK= '00000'
PSH = '00100'
FIN = '00010'

seqq = 0

def generate_seq_nr(seq = -1):
    global seqq
    if seq != -1:
        seqq += 1
        return seqq
    
    seqq = random.randint(1, 2 << 16 - 1)
    return seqq

def generate_ack_nr():
    global seqq
    return seqq + 1

def to_bytes(x):
    return "{0:b}".format(x).zfill(16)

def get_info_tudp_header(payload):
    payload = payload.decode("utf-8")
    seq = int(payload[:16], base=2)
    ack = int(payload[16:32], base=2)
    flags = payload[32:37]
    data = payload[40:]
    return (seq, ack, flags, data)

def set_tudp_header(seq, flags, data = ''):
    return bytes(to_bytes(generate_seq_nr(seq)) + to_bytes(generate_ack_nr()) + flags + '000' + data, encoding="UTF-8")

