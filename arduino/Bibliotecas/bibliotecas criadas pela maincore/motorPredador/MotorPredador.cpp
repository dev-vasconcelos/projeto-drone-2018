#include "Arduino.h"
#include "MotorPredador.h"
#include <Servo.h>


MotorPredador::MotorPredador(){
    
}

MotorPredador::MotorPredador(int gpin, int rpin, int wpin, int ypin){
    setAllPin(gpin, rpin, wpin, ypin);
    stopAll();
}

void  MotorPredador::setAllPin(int greenPin, int redPin, int whitePin, int yellowPin){
    _greenEsc.attach(greenPin);
    _redEsc.attach(redPin);
    _whiteEsc.attach(whitePin);
    _yellowEsc.attach(yellowPin);
}

void MotorPredador::setGreenPin(int pin){
    _greenEsc.attach(pin);
}

void MotorPredador::setRedPin(int pin){
    _redEsc.attach(pin);
}

void MotorPredador::setWhitePin(int pin){
    _whiteEsc.attach(pin);
}

void MotorPredador::setYellowPin(int pin){
    _yellowEsc.attach(pin);
}

void MotorPredador::setAllSpeed(int speed){
    setGreenSpeed(speed);
    setRedSpeed(speed);
    setWhiteSpeed(speed);
    setYellowSpeed(speed);
}

void MotorPredador::setGreenSpeed(int speed){
    _speedGreen = speed;
}

void MotorPredador::setRedSpeed(int speed){
    _speedRed = speed;
}

void MotorPredador::setWhiteSpeed(int speed){
    _speedWhite = speed;
}

void MotorPredador::setYellowSpeed(int speed){
    _speedYellow = speed;
}

void MotorPredador::runAll(){
    _greenEsc.writeMicroseconds(_speedGreen);
    _redEsc.writeMicroseconds(_speedRed);
    _whiteEsc.writeMicroseconds(_speedWhite);
    _yellowEsc.writeMicroseconds(_speedYellow);

}

void MotorPredador::runGreen(){
    _greenEsc.writeMicroseconds(_speedGreen);
}

void MotorPredador::runRed(){
    _redEsc.writeMicroseconds(_speedRed);
}

void MotorPredador::runWhite(){
    _whiteEsc.writeMicroseconds(_speedWhite);
}

void MotorPredador::runYellow(){
    _yellowEsc.writeMicroseconds(_speedYellow);
}

void MotorPredador::stopAll(){
    setAllSpeed(0);
    runAll();
}

void MotorPredador::stopGreen(){
    setGreenSpeed(0);
    runGreen();
}

void MotorPredador::stopRed(){
    setRedSpeed(0);
    runRed();
}

void MotorPredador::stopWhite(){
    setWhiteSpeed(0);
    runWhite();
}

void MotorPredador::stopYellow(){
    setYellowSpeed(0);
    runYellow();
}