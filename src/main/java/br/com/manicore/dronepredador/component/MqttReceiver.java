package br.com.manicore.dronepredador.component;

import org.eclipse.paho.client.mqttv3.IMqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.MqttCallback;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.eclipse.paho.client.mqttv3.MqttPersistenceException;
import org.eclipse.paho.client.mqttv3.persist.MemoryPersistence;

public class MqttReceiver implements MqttCallback {
	
	SerialPortCommunication spc = new SerialPortCommunication();
		
	private static MqttClient client;

	String host = "tcp://192.168.1.12:1883";

	int qos = 2;

	public void connect(String host, String clientId) {
		try {
			client = new MqttClient(host, clientId, new MemoryPersistence());

			client.setCallback(this);

			client.connect();

			System.out.println("Conexão estabelecida com sucesso!");

		} catch (MqttException ex) {
			ex.printStackTrace();
		}
	}

	public void subscribe(String topic) {
		try {
			client.subscribe(topic, 2);
		} catch (MqttException e) {
			e.printStackTrace();
		}
	}

	public void publish(String data, String topic) throws MqttPersistenceException, MqttException {

		MqttMessage message = new MqttMessage(data.getBytes());
		message.setQos(qos);
		message.setRetained(false);

		client.publish(topic, message);
	}

	@Override
	public void connectionLost(Throwable cause) {
		System.out.println(cause);
		System.out.println("stack: " + cause.getStackTrace());
		System.out.println("CONEXÃO PERDIDA!");
	}

	@Override
	public void messageArrived(String topic, MqttMessage message) throws Exception {
		String mensagem = new String(message.getPayload());
		System.out.println("mensagem recebida do mqtt: " + mensagem);
		
		spc.escrever(mensagem);
	}

	@Override
	public void deliveryComplete(IMqttDeliveryToken token) {
		System.out.println("mensagem enviada com sucesso!");
	}
	
	public void abrirConexaoSerialMqtt(SerialPortCommunication com, String message) {
		
	}

}
