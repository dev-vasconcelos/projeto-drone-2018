#! /bin/bash

echo "package br.com.manicore.dronepredador;" > src/main/java/br/com/manicore/dronepredador/DronePredadorApplication.java
echo 'import org.springframework.boot.SpringApplication;' >> src/main/java/br/com/manicore/dronepredador/DronePredadorApplication.java
echo 'import org.springframework.boot.autoconfigure.SpringBootApplication;' >> src/main/java/br/com/manicore/dronepredador/DronePredadorApplication.java
echo '' >> src/main/java/br/com/manicore/dronepredador/DronePredadorApplication.java
echo 'import br.com.manicore.dronepredador.component.MqttReceiver;' >> src/main/java/br/com/manicore/dronepredador/DronePredadorApplication.java
echo '' >> src/main/java/br/com/manicore/dronepredador/DronePredadorApplication.java
echo '@SpringBootApplication' >> src/main/java/br/com/manicore/dronepredador/DronePredadorApplication.java
echo 'public class DronePredadorApplication {' >> src/main/java/br/com/manicore/dronepredador/DronePredadorApplication.java
echo '' >> src/main/java/br/com/manicore/dronepredador/DronePredadorApplication.java
echo '	public static void main(String[] args) {' >> src/main/java/br/com/manicore/dronepredador/DronePredadorApplication.java
echo '	SpringApplication.run(DronePredadorApplication.class, args);' >> src/main/java/br/com/manicore/dronepredador/DronePredadorApplication.java
echo '	' >> src/main/java/br/com/manicore/dronepredador/DronePredadorApplication.java
echo '	String host = "tcp://192.168.1.12:1883";' >> src/main/java/br/com/manicore/dronepredador/DronePredadorApplication.java
echo '	' >> src/main/java/br/com/manicore/dronepredador/DronePredadorApplication.java
echo '	String clientId = "MQTT-todesesperado";' >> src/main/java/br/com/manicore/dronepredador/DronePredadorApplication.java
echo '	' >> src/main/java/br/com/manicore/dronepredador/DronePredadorApplication.java
echo '	String topic = "maincore/drone/#";' >> src/main/java/br/com/manicore/dronepredador/DronePredadorApplication.java
echo ' ' >> src/main/java/br/com/manicore/dronepredador/DronePredadorApplication.java
echo '	MqttReceiver mqttsub = new MqttReceiver();' >> src/main/java/br/com/manicore/dronepredador/DronePredadorApplication.java
echo '	mqttsub.connect(host, clientId);' >> src/main/java/br/com/manicore/dronepredador/DronePredadorApplication.java
echo '	' >> src/main/java/br/com/manicore/dronepredador/DronePredadorApplication.java
echo '	' >> src/main/java/br/com/manicore/dronepredador/DronePredadorApplication.java
echo '	mqttsub.subscribe(topic);' >> src/main/java/br/com/manicore/dronepredador/DronePredadorApplication.java
echo '	}' >> src/main/java/br/com/manicore/dronepredador/DronePredadorApplication.java
echo '}' >> src/main/java/br/com/manicore/dronepredador/DronePredadorApplication.java