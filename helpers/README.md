##### In case you have dlms packets text log and want to dissect them by wireshark

Do this:
1. Rename log to in_your_log.txt;
2. Place it in the folder with scripts generate.sh and test.py;
3. Change your directory to that folder;
4. Run bash-script with input "your_log" -> output will be \*.pcap you can open by wireshark;

Required tools:
- python3;
- od;
- text2pcap;

##### Что делает срипт generate.sh

1. Удаляет из папки все бинарники;
2. Лог обмена со счетчиком in_any_name.txt переименовывается в in_log.txt, потому что python-скрипт ищет файл с таким именем;
3. Запускается python-скрипт test.py -> на выходе получится N бинарных файлов названные буквами алфавита.
Каждый файл содержит только один пакет из обмена, файлы называются по буквам алфавита.
4. Все сгенерированные python-скриптом бинарные файлы преобразовываются с помощью утилиты od к виду, который был бы понятным для text2pcap.
А с помощью text2pcap из этих данных сгенерируется файл захваченных пакетов для Wireshark.
Делается это с помощью такой команды для командной строки:
find /mnt/d/Work/Programming/dlms/dlms -name "\*.bin" -exec od -Ax -tx1 -v {} \; | text2pcap -l 147 - /mnt/d/Work/Programming/dlms/dlms/dlms.pcap
5. Удалятся все бинарники и in_log.txt;

##### Пояснение команды из шага 4:

- утилита find ищет все файлы в заданной папке по расширению и запускает для каждого найденного файлы утилиту od;
- утилита od преобразовывается двоичные файлы к виду понятному для text2pcap;
- данные отправляются в text2pcap, который генерирует файл захваченных пакетов для уровня связи dlt_user_0 (-l 147);

##### Кодировка UTF-16LE with BOM (Little Endian) не подходит

Преобразовывать вручную в UTF-8 уже надоело. Поэтому в скрипт добавлена ещё команда для автоматического преобразования:
iconv -o in_admtl_3.txt -f UTF-16LE -t UTF-8 in_admtl_3.txt

Единственная неприятность, что на выходе UTF-8 with BOM получается.
BOM - это три байта которые в этом случае остаются от UTF-16. Они не нужны, но и сильно не мешают.
Хотя правильнее без них.
