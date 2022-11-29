def log_to_data(log_file):
    with open(file=log_file, mode='rt', encoding='utf-8') as in_file:
        data = ''
        temp_data = ''
        line_count = 0
        for line_l in in_file.readlines():
            line = ''.join(line_l)
            if '.' in line or ':' in line or '-' in line or ' ' not in line:
                if line_count > 0:
                    temp_data += ' '
                    if '7E' in temp_data:
                        if temp_data.index('7E') < 4:
                            temp_data = temp_data[(temp_data.index('7E')):]
                    data += temp_data
                    temp_data = ''
                line_count = 0
                continue

            for symbol in '\n', ' ':
                line = line.replace(symbol, '')

            temp_data += line
            line_count += 1
            #data += line
        return data


def split_data(data):
    #data = data.replace('7E7E', '7E 7E')
    return data.split()


def packets_to_files(packets):
    for position, packet in enumerate(packets):
        temp_ch = chr(ord('a')+ int(position/25) ) + chr(ord('a')+ (position%25) )
        with open(file=f'{temp_ch}.bin', mode='wb') as file:
            ints = []
            for i in range(len(packet)):
                if i % 2 == 0:
                    str_byte = packet[i:i+2]
                    int_byte = int(str_byte, 16)
                    ints.append(int_byte)
            bytes_for_write = bytes(ints)
            file.write(bytes_for_write)


if __name__ == '__main__':
    str_data = log_to_data(log_file='in_log.txt')
    packets_data = split_data(data=str_data)
    packets_to_files(packets=packets_data)

