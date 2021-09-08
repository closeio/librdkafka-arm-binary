.PHONY: build extract_files

build:
	docker build --progress plain --platform linux/arm64 --build-arg LIBRDKAFKA_VERSION=1.7.0 -t local/kafka-arm-binary .

extract_files: build
	mkdir binary_files || true
	docker rm -f kafka-arm-binary-container || true
	docker create -ti --name kafka-arm-binary-container local/kafka-arm-binary bash
	docker cp kafka-arm-binary-container:/librdkafka_arm.tar.gz librdkafka_arm.tar.gz
	docker rm -f kafka-arm-binary-container
