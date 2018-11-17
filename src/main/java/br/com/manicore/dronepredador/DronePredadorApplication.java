package br.com.manicore.dronepredador;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import br.com.manicore.dronepredador.component.MqttReceiver;

@SpringBootApplication
public class DronePredadorApplication {

	public static void main(String[] args) {
		SpringApplication.run(DronePredadorApplication.class, args);

		String host = "tcp://192.168.1.12:1883";
		String clientId = "MQTT-todesesperado";
		String topic = "maincore/drone/#";

		MqttReceiver mqttsub = new MqttReceiver();
		mqttsub.connect(host, clientId);

		mqttsub.subscribe(topic);

	}
}
