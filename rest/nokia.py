from influxdb import InfluxDBClient
from datetime import datetime
from datetime import timedelta
import time
import config

client = InfluxDBClient(config.influx_host, config.influx_port, config.influx_user, config.influx_password,
                        config.influx_schema)


def location_data(key):
    if key not in config.locations:
        # Exception("Fuck you! You fucked it up, asshole!")
        key = 'default'

    location = config.locations[key]
    database = location['database']
    table = location['table']
    client.switch_database(database)
    result = client.query(('SELECT * from "%s" ORDER by time DESC LIMIT 50') % (table))

    humidity = 0.0
    temperature = 0.0
    number = len(result._get_series()[0]['values'])

    for el in result._get_series()[0]['values']:
        humidity += el[-5]
        temperature += el[-1]

    humidity = humidity / number
    temperature = temperature / number

    return {"humidity": humidity, "temperature": temperature}


def location_all_data(place, resp_pollution, resp_pollen):
    if place not in config.locations:
        # Exception("Fuck you! You fucked it up, asshole!")
        place = 'default'

    location = config.locations[place]
    database = location['database']
    table = location['table']
    client.switch_database(database)
    query_result = client.query(('SELECT * from "%s" ORDER by time DESC LIMIT 50') % (table))
    result = []
    date = datetime.now() - timedelta(minutes=len(query_result._get_series()[0]['values']) * 30)
    # .strftime('%Y-%m-%dT%H:%M:%SZ')

    for el in query_result._get_series()[0]['values']:
        humidity = el[-5]
        temperature = el[-1]
        date = date + timedelta(minutes=30)
        result.append({"humidity": humidity, "temperature": temperature, "air_quality": resp_pollution, "pollen": resp_pollen, "time": date.strftime('%H:%M')})

    return result
