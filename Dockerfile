FROM ubuntu:20.04

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends libssl-dev zlib1g-dev gcc g++ make git ca-certificates \
  && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/edenhill/librdkafka
WORKDIR /librdkafka
ARG LIBRDKAFKA_VERSION
RUN git checkout tags/v${LIBRDKAFKA_VERSION}
RUN ./configure --prefix=/lib_kafka
RUN make
RUN make install
WORKDIR /
RUN tar cvfz lib_kafka_arm.tar.gz /lib_kafka/