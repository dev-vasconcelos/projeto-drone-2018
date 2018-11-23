/*
    MotorPredador.h - Biblioteca para controlar os motores
    Created by Pedro Ivo Vasconcelos && Airez Antonio
    Lançado para projeto de TCC do Instituto Federal do Paraná
*/

/*
    Isso é para garantir que, caso alguém importe a Biblioteca 2 vezes,
    não haja conflito
*/
#ifndef MotorPredador_h
#define MotorPredador_h

#include <Arduino.h>
#include <Servo.h>

class MotorPredador{
    public:
        MotorPredador(); // default
        MotorPredador(int gpin, int rpin, int wpin, int ypin); //pinout

        void setAllPin(int greenPin, int redPin, int whitePin, int yellowPin);
        void setGreenPin(int pin);
        void setRedPin(int pin);
        void setWhitePin(int pin);
        void setYellowPin(int pin);

        void setAllSpeed(int speed);
        void setGreenSpeed(int speed);
        void setRedSpeed(int speed);
        void setWhiteSpeed(int speed);
        void setYellowSpeed(int speed);

        void runAll();
        void runGreen();
        void runRed();
        void runWhite();
        void runYellow();

        void stopAll();
        void stopGreen();
        void stopRed();
        void stopWhite();
        void stopYellow();

    private:
    //Por questões de convenção, é comum colocar um underline antes das var privates
        int _speedGreen;
        int _speedRed;
        int _speedWhite;
        int _speedYellow;

        Servo _whiteEsc;
        Servo _greenEsc;
        Servo _yellowEsc;
        Servo _redEsc;
};

#endif