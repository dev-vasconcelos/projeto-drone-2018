#!/bin/bash

echo "RODAR SOMENTE A PARTIR DA PASTA RAIZ"

read -p "qual o caminho hardCoded do jar" jar
read -p "qual o ip(somente o ip) do servidor MQTT?" ipMqtt
read -p 'qual a porta de comunicação ativa?' porta 

##comandos prévios
	chmod 777 $porta
	
	sudo apt update
	sudo apt-get -y install maven

	mvn compile
	mvn exec:java
	mvn package
##

arquivoSerial='src/main/java/br/com/manicore/dronepredador/component/SerialPortCommunication.java'
arquivoAplication="src/main/java/br/com/manicore/dronepredador/DronePredadorApplication.java"
arquivoRcLocal=/etc/rc.local


#DRONE APPLICATION IP MQTT

echo "package br.com.manicore.dronepredador;" > $arquivoAplication
echo 'import org.springframework.boot.SpringApplication;' >> $arquivoAplication
echo 'import org.springframework.boot.autoconfigure.SpringBootApplication;' >> $arquivoAplication
echo '' >> $arquivoAplication
echo 'import br.com.manicore.dronepredador.component.MqttReceiver;' >> $arquivoAplication
echo '' >> $arquivoAplication
echo '@SpringBootApplication' >> $arquivoAplication
echo 'public class DronePredadorApplication {' >> $arquivoAplication
echo '' >> $arquivoAplication
echo ' public static void main(String[] args) {' >> $arquivoAplication
echo ' SpringApplication.run(DronePredadorApplication.class, args);' >> $arquivoAplication
echo ' ' >> $arquivoAplication
echo ' String host = "tcp://'$ipMqtt':1883";' >> $arquivoAplication
echo ' ' >> $arquivoAplication
echo ' String clientId = "MQTT-todesesperado";' >> $arquivoAplication
echo ' ' >> $arquivoAplication
echo ' String topic = "maincore/drone/#";' >> $arquivoAplication
echo ' ' >> $arquivoAplication
echo ' MqttReceiver mqttsub = new MqttReceiver();' >> $arquivoAplication
echo ' mqttsub.connect(host, clientId);' >> $arquivoAplication
echo ' ' >> $arquivoAplication
echo ' ' >> $arquivoAplication
echo ' mqttsub.subscribe(topic);' >> $arquivoAplication
echo ' }' >> $arquivoAplication
echo '}' >> $arquivoAplication


## PORTA SERIAL

echo 'package br.com.manicore.dronepredador.component; ' > arquivoSerial
echo '' >> arquivoSerial
echo 'import java.io.BufferedReader;' >> arquivoSerial
echo 'import java.io.InputStreamReader;' >> arquivoSerial
echo 'import java.io.OutputStream;' >> arquivoSerial
echo '' >> arquivoSerial
echo 'import com.fazecast.jSerialComm.SerialPort;' >> arquivoSerial
echo 'import com.fazecast.jSerialComm.SerialPortDataListener;' >> arquivoSerial
echo 'import com.fazecast.jSerialComm.SerialPortEvent;' >> arquivoSerial
echo '' >> arquivoSerial
echo 'public class SerialPortCommunication implements SerialPortDataListener{' >> arquivoSerial
echo '' >> arquivoSerial
echo '	private static final SerialPort[] PORT_NAMES = SerialPort.getCommPorts();' >> arquivoSerial
echo '' >> arquivoSerial
echo '	private SerialPort serialPort;' >> arquivoSerial
echo '' >> arquivoSerial
echo '	private BufferedReader input;' >> arquivoSerial
echo '	/** The output stream to the port */' >> arquivoSerial
echo '	private OutputStream output;' >> arquivoSerial
echo '' >> arquivoSerial
echo '	private Object port;' >> arquivoSerial
echo '' >> arquivoSerial
echo '' >> arquivoSerial
echo '	private Long idCard;' >> arquivoSerial
echo '	/** Milliseconds to block while waiting for port open */' >> arquivoSerial
echo '	private static final int TIME_OUT = 2000;' >> arquivoSerial
echo '	/** Default bits per second for COM port. */' >> arquivoSerial
echo '	private static final int DATA_RATE = 9600;' >> arquivoSerial
echo '' >> arquivoSerial
echo '	private static final int DATA_BITS = 8;' >> arquivoSerial
echo '' >> arquivoSerial
echo '' >> arquivoSerial
echo '	' >> arquivoSerial
echo '	public SerialPortCommunication() {' >> arquivoSerial
echo '		initialize();' >> arquivoSerial
echo '	}' >> arquivoSerial
echo '' >> arquivoSerial
echo '	public void initialize() {' >> arquivoSerial
echo '		serialPort = SerialPort.getCommPort("'$porta'");' >> arquivoSerial
echo '' >> arquivoSerial
echo '		try {' >> arquivoSerial
echo '			serialPort.openPort();' >> arquivoSerial
echo '			// set port parameters' >> arquivoSerial
echo '			serialPort.setComPortParameters(DATA_RATE, DATA_BITS, SerialPort.ONE_STOP_BIT, SerialPort.NO_PARITY);' >> arquivoSerial
echo '' >> arquivoSerial
echo '			serialPort.setComPortTimeouts(SerialPort.TIMEOUT_READ_SEMI_BLOCKING, 100, 0); ' >> arquivoSerial
echo '' >> arquivoSerial
echo '			// open the streams' >> arquivoSerial
echo '			input = new BufferedReader(new InputStreamReader(serialPort.getInputStream()));' >> arquivoSerial
echo '			output = serialPort.getOutputStream();' >> arquivoSerial
echo '' >> arquivoSerial
echo '			serialPort.addDataListener(this);' >> arquivoSerial
echo '			// serialPort.;' >> arquivoSerial
echo '' >> arquivoSerial
echo '		} catch (Exception e) {' >> arquivoSerial
echo '			System.out.println("Port not found: " + e.getMessage());' >> arquivoSerial
echo '		}' >> arquivoSerial
echo '		if (serialPort.isOpen()) {' >> arquivoSerial
echo '			System.out.println("na raça");' >> arquivoSerial
echo '		}' >> arquivoSerial
echo '	}' >> arquivoSerial
echo '' >> arquivoSerial
echo '	public void close() {' >> arquivoSerial
echo '		try {' >> arquivoSerial
echo '			serialPort.closePort();' >> arquivoSerial
echo '			serialPort.removeDataListener();' >> arquivoSerial
echo '			System.out.println("Porta encerrada com sucesso!!");' >> arquivoSerial
echo '		} catch (Exception e) {' >> arquivoSerial
echo 'System.out.println("Porta nao pode ser fechada: " + e.getMessage());' >> arquivoSerial
echo '		}' >> arquivoSerial
echo '	}' >> arquivoSerial
echo '' >> arquivoSerial
echo '	@Override' >> arquivoSerial
echo '	public int getListeningEvents() {' >> arquivoSerial
echo '		// TODO Auto-generated method stub' >> arquivoSerial
echo '		System.out.println("oi");' >> arquivoSerial
echo '' >> arquivoSerial
echo '		return SerialPort.LISTENING_EVENT_DATA_RECEIVED;' >> arquivoSerial
echo '	}' >> arquivoSerial
echo '	' >> arquivoSerial
echo '	public boolean isOpen() {' >> arquivoSerial
echo '		return serialPort.isOpen();' >> arquivoSerial
echo '	}' >> arquivoSerial
echo '' >> arquivoSerial
echo '	@Override' >> arquivoSerial
echo '	public synchronized void serialEvent(SerialPortEvent oEvent) {' >> arquivoSerial
echo '		System.out.println("Vai lá");' >> arquivoSerial
echo '//		String inputLine = (String) null;' >> arquivoSerial
echo '		if (oEvent.getEventType() == SerialPort.LISTENING_EVENT_DATA_RECEIVED) {' >> arquivoSerial
echo '			try {' >> arquivoSerial
echo '//				inputLine =input.readLine();' >> arquivoSerial
echo '//				System.out.println(": Id cartao lido: " + inputLine);' >> arquivoSerial
echo '				System.out.println("saindo no serialEvent");' >> arquivoSerial
echo '			} catch (Exception e) {' >> arquivoSerial
echo '				System.err.println("jbkjgjkbkjbkjb"+e.getMessage());' >> arquivoSerial
echo '			} ' >> arquivoSerial
echo '		}' >> arquivoSerial
echo '	}' >> arquivoSerial
echo '	public void escrever(String messageString) {' >> arquivoSerial
echo '		try {' >> arquivoSerial
echo '			output.write(messageString.getBytes(),0,messageString.length());' >> arquivoSerial
echo '			output.close();' >> arquivoSerial
echo '		} catch (Exception e) {' >> arquivoSerial
echo '			System.out.println("Tres lagoa: "+e.getMessage());' >> arquivoSerial
echo '		}' >> arquivoSerial
echo ' ' >> arquivoSerial
echo ' ' >> arquivoSerial
echo '	}' >> arquivoSerial
echo '' >> arquivoSerial
echo '}' >> arquivoSerial

##RC LOCAL AUTO INICIO

echo '#!/bin/bash -e' >> $arquivoRcLocal
echo '#' >> $arquivoRcLocal
echo '#rc.local' >> $arquivoRcLocal
echo '#quem leu nao eh humano' >> $arquivoRcLocal
echo '#Print the IP address' >> $arquivoRcLocal
echo '_IP=$(hostname -I) || true' >> $arquivoRcLocal
echo 'if [ "$_IP" ]; then' >> $arquivoRcLocal
echo '	printf "My IP address is %s\n" "$_IP"' >> $arquivoRcLocal
echo 'fi' >> $arquivoRcLocal
echo '' >> $arquivoRcLocal
echo 'sudo chmod 777 '$porta >> $arquivoRcLocal
echo 'java -jar' $jar >> $arquivoRcLocal
echo 'exit 0' >> $arquivoRcLocal

