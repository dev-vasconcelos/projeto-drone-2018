#!/bin/bash

arquivo=/etc/rc.local
read -p "qual a porta Serial ativa para comunicação?" portaSerial
read -p "qual o caminho hardcoded do jar?" jarPath
read -p "qual o caminho hardcoded para o py de imagem?" imagePath

echo "#!/bin/bash -e" > $arquivo
echo 'ifconfig wlan 192.168.0.169' >> $arquivo
echo 'chmod 777 '$portaSerial >> $arquivo
echo 'python3 '$imagePath >> $arquivo
echo 'java -jar '$jarPath >> $arquivo
echo "" >> $arquivo
echo "exit 0" >> $arquivo

