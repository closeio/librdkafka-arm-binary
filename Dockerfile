FROM ubuntu:20.04

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends libssl-dev zlib1g-dev libzstd-dev liblz4-dev rapidjson-dev libsasl2-dev libcurl4-openssl-dev gcc g++ make git ca-certificates python3 wget curl build-essential \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/confluentinc/librdkafka
WORKDIR /librdkafka
ARG LIBRDKAFKA_VERSION
RUN git checkout tags/v${LIBRDKAFKA_VERSION}
RUN ./configure --install-deps
RUN STATIC_LIB_libzstd=/usr/lib/aarch64-linux-gnu/libzstd.a ./configure --enable-static --prefix=/librdkafka_arm
RUN make
RUN make install
WORKDIR /
RUN tar cvfz librdkafka_arm.tar.gz /librdkafka_arm/
