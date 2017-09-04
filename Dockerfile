FROM resin/rpi-raspbian:jessie
MAINTAINER Nat Weerawan <nat@cmmc.io>

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y wget

RUN wget -q -O - http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key | apt-key add -
RUN wget -q -O /etc/apt/sources.list.d/mosquitto-jessie.list http://repo.mosquitto.org/debian/mosquitto-jessie.list
RUN apt-get update && apt-get install -y mosquitto && rm -rf /var/lib/apt/lists/* 

RUN adduser --system --disabled-password --disabled-login mosquitto

ADD run.sh /run.sh

ENV MQTT_HOST=gb.netpie.io
ENV MQTT_PORT=1883
ENV MQTT_USERNAME=YOUR_USERNAME
ENV MQTT_PASSWORD=YOUR_PASSWORD
ENV MQTT_CLIENT_ID=YOUR_CLIENTID
ENV MQTT_PREFIX=\\/gearname\\/CMMC\\/

EXPOSE 1883 9001

ENTRYPOINT ["/run.sh"] 
