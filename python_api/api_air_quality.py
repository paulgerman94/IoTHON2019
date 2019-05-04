from http.server import HTTPServer, BaseHTTPRequestHandler

from io import BytesIO
import urllib.parse
import urllib.request

import json

led_on = False

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
        global led_on
        self.send_response(200)
        self.end_headers()

        if self.path.startswith("/airquality/"):

            url = "https://api.breezometer.com/air-quality/v2/current-conditions?lat=" + self.param_get("lat") + "&lon=" + self.param_get("lon") + "&key=bf1f7b91ee47460a9ceef6d9ef11132a&features=breezometer_aqi,dominant_pollutant_concentrations,sources_and_effects"

            print(url)
            contents = urllib.request.urlopen(url).read()

            self.wfile.write(contents)
            #self.wfile.write(str.encode(contents))

        if self.path.startswith("/led/"):
            self.wfile.write(str.encode(json.dumps({"led_status": led_on})))

        if self.path.startswith("/led_on/"):
            led_on = True

        if self.path.startswith("/led_off/"):
            led_on = False


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


httpd = HTTPServer(('localhost', 8000), SimpleHTTPRequestHandler)
httpd.serve_forever()