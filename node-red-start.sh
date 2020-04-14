#!/bin/sh

CONFIG_FILE="hjhome.py"
MQTT_DEFAULT="localhost"
BAOS_DEFAULT="192.168.0.40"
IPORT_DEFAULT="192.168.0.20"
MQTT_REMOTE=""
BAOS_IP=""
IPORT_IP=""

while read name and value
do
    if [ $name = 'MQTT_SERVER' ]; then
        echo "MQTT Server IP Addr = $value"
        MQTT_REMOTE=$value
    fi
    if [ $name = 'BAOS_IP' ]; then
        echo "BAOS IP Addr = $value"
        BAOS_IP=$value
    fi
    if [ $name = 'IPORT_IP' ]; then
        echo "iPort IP Addr = $value"
        IPORT_IP=$value
    fi
done < /root/config/$CONFIG_FILE

echo "cp flow file"
HOST=`hostname`
cp /root/config/flows_hjnode-red.json /root/.node-red/flows_$HOST.json
echo "change MQTT server IP"
sed -i "s/$MQTT_DEFAULT/$MQTT_REMOTE/g" /root/.node-red/flows_$HOST.json
sed -i "s/\"$MQTT_REMOTE\"/$MQTT_REMOTE/g" /root/.node-red/flows_$HOST.json
echo "change BAOS IP"
sed -i "s/$BAOS_DEFAULT/$BAOS_IP/g" /root/.node-red/flows_$HOST.json
sed -i "s/\"$BAOS_IP\"/$BAOS_IP/g" /root/.node-red/flows_$HOST.json
echo "change iPort IP"
sed -i "s/$IPORT_DEFAULT/$IPORT_IP/g" /root/.node-red/flows_$HOST.json
sed -i "s/\"$IPORT_IP\"/$IPORT_IP/g" /root/.node-red/flows_$HOST.json

echo "start node-red"
node-red
