import RPi.GPIO as GPIO
import time
import sys

GPIO.setwarnings(False)

GPIO.setmode(GPIO.BOARD)

GPIO.setup(7, GPIO.OUT)


level = float(sys.argv[1])

level = (20 - abs(level)) * 5
if level > 100:
    level = 100
if level < 0:
    level = 0


def dim():
    red_led = GPIO.PWM(7, 100)

    red_led.start(level)

    time.sleep(0.35)


dim()
