from flask import Flask
from flask import jsonify
from flask import request

import nokia

import uuid

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello World!'


@app.route('/location')
def location():
    long = request.args.get('long')
    lat = request.args.get('lat')
    key = uuid.uuid5(uuid.NAMESPACE_DNS, lat + ',' + long)
    print(lat + ',' + long + ' - ' + str(key))
    return jsonify(nokia.location_data(str(key)))

if __name__ == '__main__':
    app.run()
