import json
import uuid

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
    resp_ericsson = ericsson.location_data()
    resp['air_quality'] = resp_ericsson
    resp.update(resp_nokia)

    return jsonify(resp)

if __name__ == '__main__':
    app.run()
