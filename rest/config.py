# Statically link a location with specific sensors and devices
locations = {
    '90e44bf2-f8de-52e2-a3bd-17a831267c42': {
        'database': 'ruuvi1',
        'table': 'ruuvi_measurements'
    },
    'default': {
        'database': 'ruuvi1',
        'table': 'ruuvi_measurements'
    }
}

influx_host = '127.0.0.1'
influx_port = 8086
influx_user = 'root'
influx_password = 'root'
influx_schema = '_internal'

ericsson_schema = 'ericsson'
ericsson_air_pollution = 'air_pollution'