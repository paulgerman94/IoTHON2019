import logging
import asyncio
import json
import ericsson

from aiocoap import *

logging.basicConfig(level=logging.INFO)

addr = 'coap://10.84.109.140'


async def coap_service():
    protocol = await Context.create_client_context()

    request = Message(code=GET, uri=addr + '/airquality?lat=23.1&lon=34.34')

    try:
        response = await protocol.request(request).response
    except Exception as e:
        print('Failed to fetch resource:')
        print(e)
    else:
        # print('Result: %s\n%r' % (response.code, response.payload))
        data = json.loads(response.payload.decode("utf-8"))
        ericsson.save_air_pollution(data)

    request = Message(code=GET, uri=addr + '/pollen?lat=23.1&lon=34.34')

    try:
        response = await protocol.request(request).response
    except Exception as e:
        print('Failed to fetch resource:')
        print(e)
    else:
        # print('Result: %s\n%r' % (response.code, response.payload))
        data = json.loads(response.payload.decode("utf-8"))
        ericsson.save_air_pollen(data)

    request = Message(code=PUT, uri=addr + '/led', payload=b'off')

    try:
        response = await protocol.request(request).response
    except Exception as e:
        print('Failed to fetch resource:')
        print(e)
    # else:
    #     print('Result: %s\n%r' % (response.code, response.payload))


async def coap_switch_light():

    protocol = await Context.create_client_context()

    request = Message(code=GET, uri=addr + '/led')

    try:
        response = await protocol.request(request).response
    except Exception as e:
        print('Failed to fetch resource:')
        print(e)

    if "on" == response.payload.decode("utf-8"):
        payload = b'off'
    else:
        payload = b'on'

    request = Message(code=PUT, uri=addr + '/led', payload=payload)

    try:
        response = await protocol.request(request).response
    except Exception as e:
        print('Failed to fetch resource:')
        print(e)