/*
    AsciiConverter.h - Biblioteca para conversão de código ASCII
    Created by Pedro Ivo M. de Vasconcelos && Airez Antonio da Rocha
    Lançado para projeto de TCC do Instituto Federal do Paraná
*/

#ifndef AsciiConverter_h
#define AsciiConverter_h

#include<Arduino.h>

class AsciiConverter{
    public:
        char convertChar(int value);
        String convertString(int value);
};

#endif