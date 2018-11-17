package br.com.manicore.dronepredador.component;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;

import com.fazecast.jSerialComm.SerialPort;
import com.fazecast.jSerialComm.SerialPortDataListener;
import com.fazecast.jSerialComm.SerialPortEvent;

public class SerialPortCommunication implements SerialPortDataListener{

	private static final SerialPort[] PORT_NAMES = SerialPort.getCommPorts();

	private SerialPort serialPort;

	private BufferedReader input;
	/** The output stream to the port */
	private OutputStream output;

	private Object port;


	private Long idCard;
	/** Milliseconds to block while waiting for port open */
	private static final int TIME_OUT = 2000;
	/** Default bits per second for COM port. */
	private static final int DATA_RATE = 9600;

	private static final int DATA_BITS = 8;


	
	public SerialPortCommunication() {
		initialize();
	}

	public void initialize() {
		serialPort = SerialPort.getCommPort("/dev/ttyACM1");

		try {
			serialPort.openPort();
			// set port parameters
			serialPort.setComPortParameters(DATA_RATE, DATA_BITS, SerialPort.ONE_STOP_BIT, SerialPort.NO_PARITY);

			serialPort.setComPortTimeouts(SerialPort.TIMEOUT_READ_SEMI_BLOCKING, 100, 0);

			// open the streams
			input = new BufferedReader(new InputStreamReader(serialPort.getInputStream()));
			output = serialPort.getOutputStream();

			serialPort.addDataListener(this);
			// serialPort.;

		} catch (Exception e) {
			System.out.println("Port not found: " + e.getMessage());
		}
		if (serialPort.isOpen()) {
			System.out.println("na raça");
		}
	}

	public void close() {
		try {
			serialPort.closePort();
			serialPort.removeDataListener();
			System.out.println("Porta encerrada com sucesso!!");
		} catch (Exception e) {
			System.out.println("Porta nao pode ser fechada: " + e.getMessage());
		}
	}

	@Override
	public int getListeningEvents() {
		// TODO Auto-generated method stub
		System.out.println("oi");

		return SerialPort.LISTENING_EVENT_DATA_RECEIVED;
	}
	
	public boolean isOpen() {
		return serialPort.isOpen();
	}

	@Override
	public synchronized void serialEvent(SerialPortEvent oEvent) {
		System.out.println("Vai lá");
//		String inputLine = (String) null;
		if (oEvent.getEventType() == SerialPort.LISTENING_EVENT_DATA_RECEIVED) {
			try {
//				inputLine =input.readLine();
//				System.out.println(": Id cartao lido: " + inputLine);
				System.out.println("saindo no serialEvent");
			} catch (Exception e) {
				System.err.println("jbkjgjkbkjbkjb"+e.getMessage());
			} 
		}
	}
	public void escrever(String messageString) {
		try {
			output.write(messageString.getBytes(),0,messageString.length());
			output.close();
		} catch (Exception e) {
			System.out.println("Tres lagoa: "+e.getMessage());
		}
		
	}

}
