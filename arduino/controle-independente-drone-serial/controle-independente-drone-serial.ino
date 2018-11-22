#include<Servo.h>

Servo escBranco;
Servo escVerde;
Servo escAmarelo;
Servo escVermelho;

int speedVerde, speedAmarelo, speedBranco, speedVermelho;
int leitura, vel, motor;
bool checkAmarelo = false;
bool checkVermelho = false;
bool checkBranco = false;
bool checkVerde = false;
bool checkAll = false;

void setup(){
  Serial.begin(9600);

  escBranco.attach(2);
  escVerde.attach(3);
  escAmarelo.attach(5);
  escVermelho.attach(7);

  setAllSpeed(1000);
  stopAll();
}

void loop() {
  leitura = Serial.read();
  if(leitura!= -1)
    Serial.print(leitura);
    
  if(leitura > 47 && leitura < 58 ){
    vel = map(leitura, 48, 57, 0, 9);
    vel = map(vel, 0, 9, 1000, 2000);
  }else if(leitura != -1 && leitura != 10){
    motor = leitura;
  }
  if (vel != 0 && leitura != -1){
    Serial.print("velocidade");
    Serial.print(vel);
    Serial.print("motor:");
    Serial.print(motor);

    Serial.print("map");
    Serial.print(vel);

    if(vel == 1000)
      getCodigo(0, motor);
    else
      getCodigo(vel, motor);
    
    vel = 0;
    motor = 0;
  }
}

//CÓDIGOS
void getCodigo(int vel, int opcaoMotor){
  switch(opcaoMotor){
    case 97: //a
    if(!checkAll && vel != 0){
      setAllSpeed(vel);
      runAll();
      setAllStatus(true);
    }else{
      stopAll();
      setAllStatus(false);
    }
    break;

    case 98: //c
    if(!checkVerde && vel != 0){
      setSpeedVerde(vel);
      runVerde();
      checkVerde = true;
    }else{
      stopVerde();
      checkVerde = false;
    }
    break;

    case 99: //d
    if(!checkAmarelo && vel != 0){
      setSpeedAmarelo(vel);
      runAmarelo();
      checkAmarelo = true;
    }else{
      stopAmarelo();
      checkAmarelo = false;
    }
    break;

    case 100: //e
    if(!checkVermelho && vel != 0){
      setSpeedVermelho(vel);
      runVermelho();
      checkVermelho = true;
    }else{
      stopVermelho();
      checkVermelho = false;
    }
    break;

    case 101: //f
    if(!checkBranco && vel != 0){
      setSpeedBranco(vel);
      runBranco();
      checkBranco = true;
    }else{
      stopBranco();
      checkBranco = false;
    }
    break;
    
  }
}

//SET SPEED
void setAllSpeed(int vel){
  speedVerde = vel;
  speedAmarelo = vel;
  speedBranco = vel;
  speedVermelho = vel;
}

void setSpeedVerde(int vel){
  speedVerde = vel;  
}

void setSpeedVermelho(int vel){
  speedVermelho = vel;  
}

void setSpeedAmarelo(int vel){
  speedAmarelo = vel;
}

void setSpeedBranco(int vel){
  speedBranco = vel;  
}

//RUN
void runAll(){
  escBranco.writeMicroseconds(speedBranco);
  escVermelho.writeMicroseconds(speedVermelho);
  escAmarelo.writeMicroseconds(speedAmarelo);
  escVerde.writeMicroseconds(speedVerde);
}

void runAmarelo(){
  escAmarelo.writeMicroseconds(speedAmarelo);
}

void runVermelho(){
  escVermelho.writeMicroseconds(speedVermelho);
}

void runBranco(){
  escBranco.writeMicroseconds(speedBranco);
}

void runVerde(){
  escVerde.writeMicroseconds(speedVerde);  
}


//STOP
void stopAll(){
  setAllSpeed(0);
  runAll();
}

void stopVerde(){
  setSpeedVerde(0);
  runVerde();
}

void stopBranco(){
  setSpeedBranco(0);
  runBranco();
}

void stopAmarelo(){
  setSpeedAmarelo(0);
  runAmarelo();
}

void stopVermelho(){
  setSpeedVermelho(0);
  runVermelho();
}


void setAllStatus(bool status){
  checkAmarelo = status;
  checkVerde = status;
  checkVermelho = status;
  checkBranco = status;
  checkAll = status;
}
