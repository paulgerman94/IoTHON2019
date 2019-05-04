import asyncio
import json
import uuid
import coap
import time

from flask import Flask
from flask import jsonify
from flask import request

import ericsson
import nokia

app = Flask(__name__)


@app.route('/')
def hello_world():
    ericsson.save_air_pollution(json.loads(ericsson.sample_data))
    return 'Hello World!'


@app.route('/location')
def location():
    long = request.args.get('long')
    lat = request.args.get('lat')

    key = str(uuid.uuid5(uuid.NAMESPACE_DNS, lat + ',' + long))
    print(lat + ',' + long + ' - ' + key)

    resp = {}
    resp_nokia = nokia.location_data(key)
    resp_pollen = ericsson.location_pollen_data()
    resp_pollution = ericsson.location_pollution_data()
    resp['pollen'] = resp_pollen
    resp['air_quality'] = resp_pollution

    resp.update(resp_nokia)

    return jsonify(resp)


@app.route('/location_all')
def all_location():
    place = request.args.get('lat')

    resp_ericsson = ericsson.location_data()
    resp = nokia.location_all_data(place, resp_ericsson)

    return jsonify(resp)


asyncio.get_event_loop().run_until_complete(coap.coap_service())

if __name__ == '__main__':
    app.run()
