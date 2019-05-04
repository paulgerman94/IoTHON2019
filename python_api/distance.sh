#!/usr/bin/env bash

while true; do
    val=$(hcitool rssi 5C:FB:7C:75:F0:4B | grep -Eo '[+-]?[0-9]+([.][0-9]+)?')
    echo ${val}

    python3 led.py ${val}
done