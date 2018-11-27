#! /bin/bash

read -p 'Porta de comunicao' porta 

arquivo='src/main/java/br/com/manicore/dronepredador/component/SerialPortCommunication.java'

echo 'package br.com.manicore.dronepredador.component; ' > $arquivo
echo '' >> $arquivo
echo 'import java.io.BufferedReader;' >> $arquivo
echo 'import java.io.InputStreamReader;' >> $arquivo
echo 'import java.io.OutputStream;' >> $arquivo
echo '' >> $arquivo
echo 'import com.fazecast.jSerialComm.SerialPort;' >> $arquivo
echo 'import com.fazecast.jSerialComm.SerialPortDataListener;' >> $arquivo
echo 'import com.fazecast.jSerialComm.SerialPortEvent;' >> $arquivo
echo '' >> $arquivo
echo 'public class SerialPortCommunication implements SerialPortDataListener{' >> $arquivo
echo '' >> $arquivo
echo '	private static final SerialPort[] PORT_NAMES = SerialPort.getCommPorts();' >> $arquivo
echo '' >> $arquivo
echo '	private SerialPort serialPort;' >> $arquivo
echo '' >> $arquivo
echo '	private BufferedReader input;' >> $arquivo
echo '	/** The output stream to the port */' >> $arquivo
echo '	private OutputStream output;' >> $arquivo
echo '' >> $arquivo
echo '	private Object port;' >> $arquivo
echo '' >> $arquivo
echo '' >> $arquivo
echo '	private Long idCard;' >> $arquivo
echo '	/** Milliseconds to block while waiting for port open */' >> $arquivo
echo '	private static final int TIME_OUT = 2000;' >> $arquivo
echo '	/** Default bits per second for COM port. */' >> $arquivo
echo '	private static final int DATA_RATE = 9600;' >> $arquivo
echo '' >> $arquivo
echo '	private static final int DATA_BITS = 8;' >> $arquivo
echo '' >> $arquivo
echo '' >> $arquivo
echo '	' >> $arquivo
echo '	public SerialPortCommunication() {' >> $arquivo
echo '		initialize();' >> $arquivo
echo '	}' >> $arquivo
echo '' >> $arquivo
echo '	public void initialize() {' >> $arquivo
echo '		serialPort = SerialPort.getCommPort("'$porta'");' >> $arquivo
echo '' >> $arquivo
echo '		try {' >> $arquivo
echo '			serialPort.openPort();' >> $arquivo
echo '			// set port parameters' >> $arquivo
echo '			serialPort.setComPortParameters(DATA_RATE, DATA_BITS, SerialPort.ONE_STOP_BIT, SerialPort.NO_PARITY);' >> $arquivo
echo '' >> $arquivo
echo '			serialPort.setComPortTimeouts(SerialPort.TIMEOUT_READ_SEMI_BLOCKING, 100, 0); ' >> $arquivo
echo '' >> $arquivo
echo '			// open the streams' >> $arquivo
echo '			input = new BufferedReader(new InputStreamReader(serialPort.getInputStream()));' >> $arquivo
echo '			output = serialPort.getOutputStream();' >> $arquivo
echo '' >> $arquivo
echo '			serialPort.addDataListener(this);' >> $arquivo
echo '			// serialPort.;' >> $arquivo
echo '' >> $arquivo
echo '		} catch (Exception e) {' >> $arquivo
echo '			System.out.println("Port not found: " + e.getMessage());' >> $arquivo
echo '		}' >> $arquivo
echo '		if (serialPort.isOpen()) {' >> $arquivo
echo '			System.out.println("na raça");' >> $arquivo
echo '		}' >> $arquivo
echo '	}' >> $arquivo
echo '' >> $arquivo
echo '	public void close() {' >> $arquivo
echo '		try {' >> $arquivo
echo '			serialPort.closePort();' >> $arquivo
echo '			serialPort.removeDataListener();' >> $arquivo
echo '			System.out.println("Porta encerrada com sucesso!!");' >> $arquivo
echo '		} catch (Exception e) {' >> $arquivo
echo 'System.out.println("Porta nao pode ser fechada: " + e.getMessage());' >> $arquivo
echo '		}' >> $arquivo
echo '	}' >> $arquivo
echo '' >> $arquivo
echo '	@Override' >> $arquivo
echo '	public int getListeningEvents() {' >> $arquivo
echo '		// TODO Auto-generated method stub' >> $arquivo
echo '		System.out.println("oi");' >> $arquivo
echo '' >> $arquivo
echo '		return SerialPort.LISTENING_EVENT_DATA_RECEIVED;' >> $arquivo
echo '	}' >> $arquivo
echo '	' >> $arquivo
echo '	public boolean isOpen() {' >> $arquivo
echo '		return serialPort.isOpen();' >> $arquivo
echo '	}' >> $arquivo
echo '' >> $arquivo
echo '	@Override' >> $arquivo
echo '	public synchronized void serialEvent(SerialPortEvent oEvent) {' >> $arquivo
echo '		System.out.println("Vai lá");' >> $arquivo
echo '//		String inputLine = (String) null;' >> $arquivo
echo '		if (oEvent.getEventType() == SerialPort.LISTENING_EVENT_DATA_RECEIVED) {' >> $arquivo
echo '			try {' >> $arquivo
echo '//				inputLine =input.readLine();' >> $arquivo
echo '//				System.out.println(": Id cartao lido: " + inputLine);' >> $arquivo
echo '				System.out.println("saindo no serialEvent");' >> $arquivo
echo '			} catch (Exception e) {' >> $arquivo
echo '				System.err.println("jbkjgjkbkjbkjb"+e.getMessage());' >> $arquivo
echo '			} ' >> $arquivo
echo '		}' >> $arquivo
echo '	}' >> $arquivo
echo '	public void escrever(String messageString) {' >> $arquivo
echo '		try {' >> $arquivo
echo '			output.write(messageString.getBytes(),0,messageString.length());' >> $arquivo
echo '			output.close();' >> $arquivo
echo '		} catch (Exception e) {' >> $arquivo
echo '			System.out.println("Tres lagoa: "+e.getMessage());' >> $arquivo
echo '		}' >> $arquivo
echo ' ' >> $arquivo
echo ' ' >> $arquivo
echo '	}' >> $arquivo
echo '' >> $arquivo
echo '}' >> $arquivo

