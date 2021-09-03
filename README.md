# librdkafka-arm-binary
## Why
librdkafka, which is a dependency of Kafka python library, has no public arm64 binary. We need to compile it on our own https://github.com/confluentinc/confluent-kafka-python/issues/462#issuecomment-427657824


## How
`make extract_files` will build docker arm64 image, compile librdkafka for arm and copy it to `binary_files` folder on the host. 

Then we manually create a Github release with the extracted binary files.

