.PHONY: build-docker all

curdir=$(shell pwd)

all:
	make build-docker
	make build-runit

build-docker:
	docker build -t runit-builder .

build-runit:
	docker run -ti --rm -v $(curdir):/builder runit-builder
