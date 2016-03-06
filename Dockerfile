FROM resin/rpi-raspbian

MAINTAINER Þafak Soylu <dawnoble@hotmail.com>

RUN apt-get update \
        && apt-get install g++ protobuf-compiler libprotobuf-dev \
        && apt-get install libboost-dev curl m4 wget \
        && wget http://download.rethinkdb.com/dist/rethinkdb-2.2.5.tgz \
        && tar xf rethinkdb-2.2.5.tgz

WORKDIR rethinkdb-2.2.5

RUN ./configure --with-system-malloc --allow-fetch \
        && make ALLOW_WARNINGS=1 \
        && sudo make install ALLOW_WARNINGS=1

CMD ["rethinkdb", "--bind", "all"]

#   process cluster webui
EXPOSE 28015 29015 8080
