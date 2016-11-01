# CMMC Docker Mosquitto

    docker build . -t mosquitto
    docker run -p 1883:1883 -p 9001:9001 mosquitto
    docker run -p 1883:1883 -p 9001:9001  -v $(pwd)/config/mosquitto.conf:/mosquitto/mosquitto.conf mosquitto
