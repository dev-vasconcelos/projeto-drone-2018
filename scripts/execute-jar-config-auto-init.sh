#! /bin/bash

read -p "caminho do jar para ser executado hardcoded" jar
read -p "porta serial configurada em ambos raspberry e aplicacao" portaSerial

arquivo='/etc/rc.local'

#java -jar drone-predador-0.0.1-SNAPSHOT.jar

chmod 777 $portaSerial
java -jar $jar


echo '#!/bin/bash -e' >> $arquivo
echo '#' >> $arquivo
echo '#rc.local' >> $arquivo
echo '#quem leu nao eh humano' >> $arquivo
echo '#Print the IP address' >> $arquivo
echo '_IP=$(hostname -I) || true' >> $arquivo
echo 'if [ "$_IP" ]; then' >> $arquivo
echo '	printf "My IP address is %s\n" "$_IP"' >> $arquivo
echo 'fi' >> $arquivo
echo '' >> $arquivo
echo 'sudo chmod 777 '$portaSerial >> $arquivo
echo 'java -jar' $jar >> $arquivo
echo 'exit 0' >> $arquivo

