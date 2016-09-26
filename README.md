docker build . -t mosquitto
docker run -p 1883:1883 -p 9001:9001 mosquitto
docker run -p 1883:1883 -p 9001:9001  -v /root/cmmc-mosquitto/config/mosquitto.conf:/mosquitto/mosquitto.conf mosquitto
