import datetime
import time

from influxdb import InfluxDBClient

import config

sample_data = '{"metadata": null, "data": {"datetime": "2019-05-04T11:00:00Z", "data_available": true, "indexes": {"baqi": {"display_name": "BreezoMeter AQI", "aqi": 75, "aqi_display": "75", "color": "#6EC634", "category": "Good air quality", "dominant_pollutant": "o3"}}, "pollutants": {"o3": {"display_name": "O3", "full_name": "Ozone", "concentration": {"value": 31.77, "units": "ppb"}, "sources_and_effects": {"sources": "Ozone is created in a chemical reaction between atmospheric oxygen, nitrogen oxides, carbon monoxide and organic compounds, in the presence of sunlight.", "effects": "Ozone can irritate the airways and cause coughing, a burning sensation, wheezing and shortness of breath. Additionally, ozone is one of the major components of photochemical smog."}}}}, "error": null}'


def init_influx():
    client = InfluxDBClient(config.influx_host, config.influx_port, config.influx_user, config.influx_password,
                            config.influx_schema)
    client.switch_database(config.ericsson_schema)
    # change this shitty logic
    #client.drop_database(config.ericsson_pollution_db)

    # print("Create database: " + config.ericsson_pollution_db)
    # client.create_database(config.ericsson_pollution_db)
    #
    # print("Create a retention policy")
    # client.create_retention_policy('awesome_policy', '3d', 3, default=True)

    return client


client = init_influx()


def save_air_pollution(data):
    json_body = prepare_air_pollution_json(data)
    # print("Write points: {0}".format(json_body))
    client.write_points(json_body)


def prepare_air_pollution_json(data):
    date = datetime.datetime.fromtimestamp(time.time()).strftime('%Y-%m-%dT%H:%M:%SZ')
    json_body = [
        {
            "measurement": config.ericsson_air_pollution,
            "time": date,
            "fields": {
                "type": data['data']['indexes']['baqi']['category'],
                "dominant_pollutant": data['data']['indexes']['baqi']['dominant_pollutant'],
            }
        }
    ]
    return json_body

def location_data():
    database = config.ericsson_schema
    table = config.ericsson_air_pollution
    client.switch_database(database)
    result = client.query(('SELECT * from "%s" ORDER by time DESC LIMIT 50') % (table))

    type = "Good air quality"
    dominant_pollutant = "o3"

    for el in result._get_series()[0]['values']:
        if type != el[2]:
            type = el[2]
            dominant_pollutant = el[1]

    return {"type": type, "dominant_pollutant": dominant_pollutant}