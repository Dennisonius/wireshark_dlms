#!/usr/bin/bash
# comment
STRING="generate wireshark file from txt"
HELPERS_DIR=/mnt/d/Work/Programming/dlms/wireshark_dlms/helpers
#print on a screen
echo $STRING

# 1. remove all files *.bin type
echo $(find $HELPERS_DIR -name "*.bin" -delete)

# 2. change target input file name to in_log.txt
cp in_$1.txt in_log.txt

# 3. run python script
echo $(python3 $HELPERS_DIR/test.py)

# 4. create .pcap wireshark file from *.bin files contained packets data
echo $(find $HELPERS_DIR -name "*.bin" -exec od -Ax -tx1 -v {} \; | text2pcap -l 147 - $HELPERS_DIR/dlms_$1.pcap)

# 5. remove all files *.bin type and in_log.txt
echo $(find $HELPERS_DIR -name "*.bin" -delete)
rm in_log.txt
