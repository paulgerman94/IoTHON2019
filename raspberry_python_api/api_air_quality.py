from http.server import HTTPServer, BaseHTTPRequestHandler

from io import BytesIO
import urllib.parse
import urllib.request
import RPi.GPIO as GPIO
from pygame import mixer
import json

GPIO.setmode(GPIO.BOARD)

GPIO.setup(11, GPIO.OUT)

led_on = False
alarm_on = False

API_KEY = "bf1f7b91ee47460a9ceef6d9ef11132a"


class SimpleHTTPRequestHandler(BaseHTTPRequestHandler):
    def __init__(self, request, client_address, server):
        super().__init__(request, client_address, server)
        print("ion")

    def param_get(self, param):
        val = urllib.parse.parse_qs(urllib.parse.urlparse(self.path).query).get(param, None)
        if val:
            return val[0]
        else:
            return ""

    def do_GET(self):
        global led_on, alarm_on
        self.send_response(200)
        self.end_headers()

        if self.path.startswith("/airquality/"):

            url = "https://api.breezometer.com/air-quality/v2/current-conditions?lat=" + self.param_get("lat") + "&lon=" + self.param_get("lon") + "&key=" + API_KEY + "&features=breezometer_aqi,dominant_pollutant_concentrations,sources_and_effects"

            print(url)
            contents = urllib.request.urlopen(url).read()

            self.wfile.write(contents)
            #self.wfile.write(str.encode(contents))

        if self.path.startswith("/pollen/"):
            url = "https://api.breezometer.com/pollen/v2/current-conditions?lat=" + self.param_get("lat") + "&lon=" + self.param_get("lon") + "&key=" + API_KEY + "&features=types_information"

            print(url)
            contents = urllib.request.urlopen(url).read()

            self.wfile.write(contents)
            #self.wfile.write(str.encode(contents))

        if self.path.startswith("/led/"):
            self.wfile.write(str.encode(json.dumps({"led_status": led_on})))

        if self.path.startswith("/led_on/"):
            GPIO.output(11, GPIO.HIGH)
            led_on = True

        if self.path.startswith("/led_off/"):
            GPIO.output(11, GPIO.LOW)
            led_on = False

        if self.path.startswith("/alarm/"):
            self.wfile.write(str.encode(json.dumps({"alarm_status": alarm_on})))

        if self.path.startswith("/alarm_on/"):
            mixer.init()
            mixer.music.load("alarm.mp3")
            mixer.music.play()
            alarm_on = True

        if self.path.startswith("/alarm_off/"):
            mixer.music.stop()
            alarm_on = False

    def do_POST(self):
        content_length = int(self.headers['Content-Length'])
        body = self.rfile.read(content_length)
        self.send_response(200)
        self.end_headers()
        response = BytesIO()
        response.write(b'This is POST request. ')
        response.write(b'Received: ')
        response.write(body)
        self.wfile.write(response.getvalue())


httpd = HTTPServer(('', 8000), SimpleHTTPRequestHandler)
httpd.serve_forever()
