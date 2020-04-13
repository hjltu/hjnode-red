#!/bin/sh

MQTT_LOCAL="localhost"
MQTT_REMOTE=""
CONFIG_FILE="hjhome.py"

while read name and value
do
    if [ $name = 'MQTT_SERVER' ]; then
        echo "MQTT Server IP Addr = $value"
        MQTT_REMOTE=$value
    fi
done < /root/config/$CONFIG_FILE

echo "cp flow file"
HOST=`hostname`
cp /root/config/flows_hjnode-red.json /root/.node-red/flows_$HOST.json
echo "change MQTT server IP"
sed -i "s/$MQTT_LOCAL/$MQTT_REMOTE/g" /root/.node-red/flows_$HOST.json
sed -i "s/\"$MQTT_REMOTE\"/$MQTT_REMOTE/g" /root/.node-red/flows_$HOST.json

echo "start node-red"
node-red
