#!/usr/bin/bash
# comment
SCRIPT_NAME="generate wireshark file from txt"
#HELPERS_DIR=/mnt/d/Work/Programming/dlms/dlms_log
HELPERS_DIR=/mnt/d/Work/Programming/dlms/wireshark_dlms/helpers
#print on a screen
echo $SCRIPT_NAME

cd $HELPERS_DIR

# 1. remove all files *.bin type
echo $(find $HELPERS_DIR -name "*.bin" -delete)

# 2. copy target input file into in_log.txt cause test.py exspects such file
cp in_$1.txt in_log.txt

# 3. check if encoding is utf-16le then convert to utf-8
FILE_INFO=$(file in_log.txt)
SUB_INFO='UTF-16'
if [[ "$FILE_INFO" == *"$SUB_INFO"* ]]; then
	echo "Convert from utf-16 encoding to utf-8"
	iconv -o in_log.txt -f UTF-16LE -t UTF-8 in_log.txt
fi

# 4. run python script
echo $(python3 $HELPERS_DIR/test.py)

# 5. create .pcap wireshark file from *.bin files contained packets data
echo $(find $HELPERS_DIR -name "*.bin" -exec od -Ax -tx1 -v {} \; | text2pcap -l 147 - $HELPERS_DIR/dlms_$1.pcap)

# 6. remove all files *.bin type and in_log.txt
echo $(find $HELPERS_DIR -name "*.bin" -delete)
rm in_log.txt
