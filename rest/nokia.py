from influxdb import InfluxDBClient

import config

client = InfluxDBClient('192.168.1.200', 8086, 'root', 'root', '_internal')


def location_data(key):
    if key not in config.locations:
        Exception("Fuck you! You fucked it up, asshole!")

    location = config.locations[str(key)]
    client.switch_database(location['database'])
    result = client.query(('SELECT * from "%s" ORDER by time DESC LIMIT 20') % (location['table']))

    humidity = 0.0
    temperature = 0.0
    number = len(result._get_series()[0]['values'])

    for el in result._get_series()[0]['values']:
        humidity += el[-5]
        temperature += el[-1]

    humidity = humidity / number
    temperature = temperature / number

    return {"humidity": humidity, "temperature": temperature}
