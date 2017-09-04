#!/bin/sh
set -e

#sed -i "s/remote_username YOUR_USERNAME/remote_username $MQTT_USERNAME/g" /mqtt/config/conf.d/bridges.conf
#sed -i "s/remote_password YOUR_PASSWORD/remote_password $MQTT_PASSWORD/g" /mqtt/config/conf.d/bridges.conf
#sed -i "s/remote_clientid YOUR_CLIENT_ID/remote_clientid $MQTT_CLIENT_ID/g" /mqtt/config/conf.d/bridges.conf

/usr/sbin/mosquitto -v -c /mqtt/config/mosquitto.conf
cat /mqtt/conf/conf.d/bridges.conf

exec "$@"
#docker run --user $(id -u) --rm -it -p 1883:1883 -p 9001:9001 -v $MOUNT_DATA_DIR:/mosquitto/data -v $MOUNT_LOG_DIR:/mosquitto/log  -v $MOUNT_CONF_DIR:/mqtt/config mosquitto-rpi:latest