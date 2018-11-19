#! /bin/bash

read -p "qual o ip(somente o ip) do servidor MQTT?" ipMqtt

arquivo="src/main/java/br/com/manicore/dronepredador/DronePredadorApplication.java"

echo "package br.com.manicore.dronepredador;" > $arquivo
echo 'import org.springframework.boot.SpringApplication;' >> $arquivo
echo 'import org.springframework.boot.autoconfigure.SpringBootApplication;' >> $arquivo
echo '' >> $arquivo
echo 'import br.com.manicore.dronepredador.component.MqttReceiver;' >> $arquivo
echo '' >> $arquivo
echo '@SpringBootApplication' >> $arquivo
echo 'public class DronePredadorApplication {' >> $arquivo
echo '' >> $arquivo
echo ' public static void main(String[] args) {' >> $arquivo
echo ' SpringApplication.run(DronePredadorApplication.class, args);' >> $arquivo
echo ' ' >> $arquivo
echo ' String host = "tcp://'$ipMqtt':1883";' >> $arquivo
echo ' ' >> $arquivo
echo ' String clientId = "MQTT-todesesperado";' >> $arquivo
echo ' ' >> $arquivo
echo ' String topic = "maincore/drone/#";' >> $arquivo
echo ' ' >> $arquivo
echo ' MqttReceiver mqttsub = new MqttReceiver();' >> $arquivo
echo ' mqttsub.connect(host, clientId);' >> $arquivo
echo ' ' >> $arquivo
echo ' ' >> $arquivo
echo ' mqttsub.subscribe(topic);' >> $arquivo
echo ' }' >> $arquivo
echo '}' >> $arquivo


