#! /bin/bash

sudo apt update
#sudo apt -y upgrade

sudo apt-get -y install mosquitto mosquitto-clients

#escrivao rc.local

#! /bin/bash
arquivo="/etc/rc.local"

echo '#!/bin/bash' > $arquivo
echo '_IP=$(hostname -I) || true' >> $arquivo
echo 'if [ "$_IP" ]; then' >> $arquivo
echo '  printf "My IP is %s\n" "$_IP"' >> $arquivo
echo 'fi' >> $arquivo

echo 'ifconfig wlan0 192.168.0.179' >> $arquivo

echo 'exit 0' >> $arquivo