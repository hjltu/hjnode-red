#!/bin/sh
echo "cp flow file"
HOST=`hostname`
cp /root/config/flows_hjnode-red.json /root/.node-red/flows_$HOST.json
echo "start node-red"
node-red
