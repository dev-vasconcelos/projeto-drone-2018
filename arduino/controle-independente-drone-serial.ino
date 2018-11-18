#include<Servo.h>

Servo escBranco;
Servo escVerde;
Servo escAmarelo;
Servo escVermelho;

int speedVerde, speedAmarelo, speedBranco, speedVermelho;
int opcao;
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
  escVermelho.attach(6);

  setAllSpeed(1000);
  stopAll();
}

void loop() {
  opcao = Serial.read();
  if(opcao != -1)
    getCodigo();
}

//CÓDIGOS
void getCodigo(){
  switch(opcao){
    case 97: //a
    if(!checkAll){
      setAllSpeed(2000);
      runAll();
      setAllStatus(true);
    }else{
      stopAll();
      setAllStatus(false);
    }
    break;

    case 98: //c
    if(!checkVerde){
      setSpeedVerde(2000);
      runVerde();
      checkVerde = true;
    }else{
      stopVerde();
      checkVerde = false;
    }
    break;

    case 99: //d
    if(!checkAmarelo){
      setSpeedAmarelo(2000);
      runAmarelo();
      checkAmarelo = true;
    }else{
      stopAmarelo();
      checkAmarelo = false;
    }
    break;

    case 100: //e
    if(!checkVermelho){
      setSpeedVermelho(2000);
      runVermelho();
      checkVermelho = true;
    }else{
      stopVermelho();
      checkVermelho = false;
    }
    break;

    case 101: //f
    if(!checkBranco){
      setSpeedBranco(2000);
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
