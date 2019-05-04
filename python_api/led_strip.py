import urllib
import random
import urllib.request
import time


leds = [0,0,0,0,0,0,0,0]


while True:
    for i in range(0, 8):
        leds[i] = random.randint(0, 254)

    IP = "10.84.109.160:8000"
    url = "http://" + IP + "/control/?"
    for i in range(0, 8):
        url = url + "l" + str(i) + "=" + str(leds[i]) + "&"


    print(url)
    contents = urllib.request.urlopen(url).read()
    time.sleep(5)
