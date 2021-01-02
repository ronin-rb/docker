all: build run

build: Dockerfile
	docker build -t ronin .

run: 
	docker run --mount type=bind,source="$$HOME",target=/home/ubuntu -it ronin

.PHONY: all build run
