FROM ubuntu:20.04

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends libssl-dev zlib1g-dev libzstd-dev libsasl2-dev gcc g++ make git ca-certificates  \
  && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/confluentinc/librdkafka
WORKDIR /librdkafka
ARG LIBRDKAFKA_VERSION
RUN git checkout tags/v${LIBRDKAFKA_VERSION}
RUN ./configure --install-deps
RUN ./configure --prefix=/librdkafka_arm
RUN make
RUN make install
WORKDIR /
RUN tar cvfz librdkafka_arm.tar.gz /librdkafka_arm/
