# librdkafka-arm-binary
## Why
Python's `confluent-kafka` module depends on librdkafka arm binary, but it [does not provide a wheel for arm](https://pypi.org/project/confluent-kafka/#files) with it.
Specifically, the compilation of the module's C extension [requires librdkafka.](https://github.com/confluentinc/confluent-kafka-python/blob/master/src/confluent_kafka/src/confluent_kafka.h#L23)
Therefore, we need to compile librdkafka for arm as suggested [here](https://github.com/confluentinc/confluent-kafka-python/issues/462#issuecomment-427657824).


## Usage
`make extract_files` will build docker arm64 image, compile librdkafka for arm, compress new `/usr` files into `librdkafka_arm.tar.gz` and copy that archive to host. 

Then we manually create a Github release with the extracted binary files.

To install the compiled binaries, extract the tar file content into `/usr` directory.
Example of Dockerfile:
```
# More at https://github.com/closeio/librdkafka-arm-binary/tree/main
RUN if [ "$TARGETPLATFORM" = "linux/arm64" ] ; then \
        curl https://github.com/closeio/librdkafka-arm-binary/releases/download/v1.7.0/librdkafka_arm.tar.gz --fail --output ./librdkafka_arm.tar.gz --location && \
        tar -xf librdkafka_arm.tar.gz && \
        cp -r librdkafka_arm/* /usr && \
        rm -r librdkafka_arm && \
        rm librdkafka_arm.tar.gz; \
    fi ;
```

