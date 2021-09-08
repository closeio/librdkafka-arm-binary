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
COPY .release/dockerfiles/closeio_app/lib_kafka.tar.gz lib_kafka.tar.gz # TODO better use curl
RUN if [ "$TARGETPLATFORM" = "linux/arm64" ] ; then tar -xf lib_kafka.tar.gz && cp -r lib_kafka/* /usr && rm -r lib_kafka ; fi ; rm lib_kafka.tar.gz
```

