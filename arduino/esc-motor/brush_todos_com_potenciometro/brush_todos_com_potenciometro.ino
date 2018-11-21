#include<Servo.h>

Servo esc;
Servo esc2;
Servo esc3;
Servo esc4;


void setup() {
  Serial.begin(9600);
  
  esc.attach(2);
  esc.attach(3);
  esc.attach(4);
  esc.attach(5);

  setAllMotorSpeed(1000);

}

void loop() {
  int val;
  val = analogRead();  
  val = map(val, 0, 1023, 1000, 2000);

  setAllMotorSpeed(val);
}

void setAllMotorSpeed(int vel){
  esc.writeMicroseconds(vel);
  esc2.writeMicroseconds(vel);
  esc3.writeMicroseconds(vel);
  esc4.writeMicroseconds(vel);
}

void setMotorUm(int vel){
  esc.writeMicroseconds(vel);
}

void setMotorDois(int val){
  esc2.writeMicroseconds(vel);
}

void setMotorTres(int val){
  esc3.writeMicroseconds(vel);
}

void setMotorQuatro(int val){
  esc4.writeMicroseconds(vel);
}
