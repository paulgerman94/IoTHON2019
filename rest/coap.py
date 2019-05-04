import logging
import asyncio
import json
import ericsson

from aiocoap import *

logging.basicConfig(level=logging.INFO)

async def coap_service():
    protocol = await Context.create_client_context()

    request = Message(code=GET, uri='coap://10.84.109.140/airquality?lat=23.1&lon=34.34')

    try:
        response = await protocol.request(request).response
    except Exception as e:
        print('Failed to fetch resource:')
        print(e)
    else:
        # print('Result: %s\n%r' % (response.code, response.payload))
        data = json.loads(response.payload.decode("utf-8"))
        ericsson.save_air_pollution(data)

    request = Message(code=PUT, uri='coap://192.168.1.174/led', payload=b'off')

    try:
        response = await protocol.request(request).response
    except Exception as e:
        print('Failed to fetch resource:')
        print(e)
    # else:
    #     print('Result: %s\n%r' % (response.code, response.payload))