import datetime
import logging

import asyncio
import urllib.request

import aiocoap.resource as resource
import aiocoap
import RPi.GPIO as GPIO
from pygame import mixer

GPIO.setmode(GPIO.BOARD)

GPIO.setup(11, GPIO.OUT)

API_KEY = "bf1f7b91ee47460a9ceef6d9ef11132a"


class AirQualityResource(resource.Resource):
    """Example resource which supports the GET and PUT methods. It sends large
    responses, which trigger blockwise transfer."""

    def __init__(self):
        super().__init__()

    async def render_get(self, request):
        url = "https://api.breezometer.com/air-quality/v2/current-conditions?lat=" + str(list(request.opt.option_list())[1]).split("=")[1] + "&lon=" + str(list(request.opt.option_list())[2]).split("=")[1] + "&key=" + API_KEY + "&features=breezometer_aqi,dominant_pollutant_concentrations,sources_and_effects"

        print(url)
        contents = urllib.request.urlopen(url).read()

        return aiocoap.Message(payload=contents)


class PollenResource(resource.Resource):
    """Example resource which supports the GET and PUT methods. It sends large
    responses, which trigger blockwise transfer."""

    def __init__(self):
        super().__init__()

    async def render_get(self, request):
        url = "https://api.breezometer.com/pollen/v2/current-conditions?lat=" + str(list(request.opt.option_list())[1]).split("=")[1] + "&lon=" + str(list(request.opt.option_list())[2]).split("=")[1]  + "&key=" + API_KEY + "&features=types_information"

        print(url)
        contents = urllib.request.urlopen(url).read()

        return aiocoap.Message(payload=contents)


class LightControl(resource.Resource):
    def __init__(self):
        self.light_on = False
        super().__init__()

    async def render_get(self, request):
        if self.light_on:
            return aiocoap.Message(payload=b"on")
        else:
            return aiocoap.Message(payload=b"off")


    async def render_put(self, request):
        if request.payload == b"on":
            print("Light on!")
            self.light_on = True
            GPIO.output(11, GPIO.HIGH)

        else:
            print("Light off!")
            GPIO.output(11, GPIO.LOW)
            self.light_on = False


        return aiocoap.Message(code=aiocoap.CHANGED, payload=request.payload)


class AlarmControl(resource.Resource):
    def __init__(self):
        self.sound_on = False
        super().__init__()

    async def render_put(self, request):
        if request.payload == b"on":
            print("Sound on!")
            self.sound_on = True
            mixer.init()
            mixer.music.load("alarm.mp3")
            mixer.music.play()

        else:
            print("Sound off!")
            mixer.music.stop()
            self.sound_on = False


        return aiocoap.Message(code=aiocoap.CHANGED, payload=request.payload)

# logging setupppp

logging.basicConfig(level=logging.INFO)
logging.getLogger("coap-server").setLevel(logging.DEBUG)


def main():
    # Resource tree creation
    root = resource.Site()

    root.add_resource(('.well-known', 'core'),
                      resource.WKCResource(root.get_resources_as_linkheader))
    root.add_resource(('airquality',), AirQualityResource())
    root.add_resource(('pollen',), PollenResource())
    root.add_resource(('led',), LightControl())
    root.add_resource(('alarm',), AlarmControl())

    asyncio.Task(aiocoap.Context.create_server_context(root))

    asyncio.get_event_loop().run_forever()


if __name__ == "__main__":
    main()
