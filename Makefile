.PHONY: build extract_files

build:
	docker build --progress plain --platform linux/arm64 --build-arg LIBRDKAFKA_VERSION=1.7.0 -t local/kafka-arm-binary .

extract_files: build
	mkdir binary_files || true
	docker rm -f kafka-arm-binary-contianery || true
	docker create -ti --name kafka-arm-binary-contianery local/kafka-arm-binary bash
	docker cp kafka-arm-binary-contianery:/lib_kafka_arm.tar.gz lib_kafka_arm.tar.gz
	docker rm -f kafka-arm-binary-contianery
