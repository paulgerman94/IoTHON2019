import serial

from http.server import HTTPServer, BaseHTTPRequestHandler
from io import BytesIO

import urllib.parse
import urllib.request

class SimpleHTTPRequestHandler(BaseHTTPRequestHandler):
    def __init__(self, request, client_address, server):
        super().__init__(request, client_address, server)

    def param_get(self, param):
        val = urllib.parse.parse_qs(urllib.parse.urlparse(self.path).query).get(param, None)
        if val:
            return val[0]
        else:
            return "0"

    def do_GET(self):
        self.send_response(200)
        self.end_headers()

        ser = serial.Serial('COM8',9600)

        if self.path.startswith("/control/"):
            for i in range(0, 9):
                val = int(self.param_get('l' + str(i)))

                if i > 4:
                    ser.write(str.encode('<' + str(i+1) + f'{val:03}' + '>')) # pollen
                else:
                    ser.write(str.encode('<' + str(i) + f'{val:03}' + '>')) # air quality


        ser.close()



httpd = HTTPServer(('', 8000), SimpleHTTPRequestHandler)
httpd.serve_forever()





