#include <AsciiConverter.h>
#include <MotorPredador.h>

AsciiConverter converter;
MotorPredador mp(1,2,3,4);

int vel, leitura;
char motor;
String output;

void setup() {
  Serial.begin(115200);
}

void loop() {
  leitura = Serial.read();
  if(leitura >= 48 && leitura <= 57){
    vel = map(leitura, 48, 57, 1000, 2000);
  }else if(leitura != -1 && leitura != 10){
    motor = converter.convertChar(leitura);
  }

  if(vel != 0 && leitura != -1){
    if(vel == 1000)
      getCodigo(0, motor);
    else
      getCodigo(vel, motor);

    vel = 0;
    motor = ' ';

    output = "motor: ";
    output += motor;
    output += ", ligado em: ";
    output += vel;

    Serial.print(output);
  }
}

//RECEBE O CÓDIGO
void getCodigo(int vel, char opcaoMotor){
  switch(opcaoMotor){
    case 'a': //a
    if(vel != 0){
      mp.setAllSpeed(vel);
      mp.runAll();
    }else{
      mp.stopAll();
    }
    break;

    case 'g': //g 
    if(vel != 0){
      mp.setGreenSpeed(vel);
      mp.runGreen();
    }else{
      mp.stopGreen();
    }
    break;

    case 'y': //y
    if(vel != 0){
      mp.setYellowSpeed(vel);
      mp.runYellow();
    }else{
      mp.stopYellow();
    }
    break;

    case 'r': //r
    if(vel != 0){
      mp.setRedSpeed(vel);
      mp.runRed();
      
    }else{
      mp.stopRed();
    }
    break;

    case 'w': //w
    if(vel != 0){
      mp.setWhiteSpeed(vel);
      mp.runWhite();
    }else{
      mp.stopWhite();
    }
    break;
    
  }
}
