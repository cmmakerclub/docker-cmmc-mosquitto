FROM ubuntu:14.04

# As reference: https://gist.github.com/hilios/6dfb40bf6b716ac97619

# Install libwebsockets
RUN apt-get update && apt-get install -y \
         build-essential \
         cmake \
         libssl-dev \
         rpm \
         wget \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*


RUN wget https://warmcat.com/git/libwebsockets/snapshot/libwebsockets-2.0.3.tar.gz \
  && tar -xzvf libwebsockets*.tar.gz \
  && cd libwebsockets-* \
  && mkdir build \
  && cd build \
  && cmake .. \
  && make \
  && make install \
  && cd ../.. \
  && rm -rvf libwebsockets* 

RUN apt-get update && apt-get install -y \
         docbook-xsl \
         libc-ares-dev \
         uuid-dev \
         xsltproc \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN cd / \
  && wget http://mosquitto.org/files/source/mosquitto-1.4.9.tar.gz \
  && tar -zxvf mosquitto-1.4.9.tar.gz \
  && cd mosquitto-1.4.9 \
  && sed -i -e s/WITH_WEBSOCKETS:=no/WITH_WEBSOCKETS:=yes/ config.mk \
  && make \
  && make install \
  && cd .. \
  && rm -rf mosquitto-1.4.9.tar.gz mosquitto-1.4.9

RUN mkdir -p /etc/mosquitto/conf.d && touch /etc/mosquitto/conf.d/users
RUN mkdir /mosquitto 
ADD config/mosquitto.conf /mosquitto/mosquitto.conf

RUN mosquitto_passwd  -b /etc/mosquitto/conf.d/users  admin admin
RUN useradd -r -m -d /var/lib/mosquitto -s /usr/sbin/nologin -g nogroup mosquitto

CMD ["/usr/local/sbin/mosquitto", "-c", "/mosquitto/mosquitto.conf", "-v"]
