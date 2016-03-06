FROM armv7/armhf-ubuntu_core

RUN apt-get update && apt-get install -y -q \
    build-essential \
    curl \
    g++ \
    libboost-dev \
    libprotobuf-dev \
    m4 \
    protobuf-compiler \
    python \
    wget \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN wget http://download.rethinkdb.com/dist/rethinkdb-2.2.5.tgz && \
    tar -zxvf rethinkdb-2.2.5.tgz && \
    cd rethinkdb-2.2.5 && \
    ./configure --with-system-malloc --allow-fetch && \
    make ALLOW_WARNINGS=1 && \
    make install ALLOW_WARNINGS=1

VOLUME ["/data"]

WORKDIR /data

CMD ["rethinkdb", "--bind", "all"]

#   process cluster webui
EXPOSE 28015 29015 8080

