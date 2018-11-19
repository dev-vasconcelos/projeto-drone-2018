#! /bin/bash

read -p "qual o nome do jar?" jar
read -p "qual a porta configurada no raspberry e na aplicação? (deve ser a mesma)" portaSerial

chmod 777 $portaSerial
java -jar $jar
