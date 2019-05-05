#include <Wire.h>
#include "Qwiic_LED_Stick.h"

const byte numChars = 32;
char receivedChars[numChars];
LED LEDStick;

boolean newData = false;

void setup() {
    Wire.begin();
  Serial.begin(9600);
  LEDStick.begin();
}

void loop() {
    recvWithStartEndMarkers();
    showNewData();
}

void recvWithStartEndMarkers() {
    static boolean recvInProgress = false;
    static byte ndx = 0;
    char startMarker = '<';
    char endMarker = '>';
    char rc;
 
    while (Serial.available() > 0 && newData == false) {
        rc = Serial.read();

        if (recvInProgress == true) {
            if (rc != endMarker) {
                receivedChars[ndx] = rc;
                ndx++;
                if (ndx >= numChars) {
                    ndx = numChars - 1;
                }
            }
            else {
                receivedChars[ndx] = '\0'; // terminate the string
                recvInProgress = false;
                ndx = 0;
                newData = true;
            }
        }

        else if (rc == startMarker) {
            recvInProgress = true;
        }
    }
}

void showNewData() {
    if (newData == true) {
        
        Serial.println(receivedChars);
        Serial.println("ok");
        String str(receivedChars);
        int command = str.toInt();
        int led = command / 1000;
        int red = command % 1000;
        Serial.println(led);
        LEDStick.setLEDColor(led, red, 255-red, 0);
        newData = false;
    }
}
