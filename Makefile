all: build

build: ubuntu lab

ubuntu: Dockerfile.ubuntu
	docker build -t ronin:ubuntu -f Dockerfile.ubuntu .

lab: ubuntu Dockerfile.lab
	docker build -t ronin:lab -f Dockerfile.lab .

clean:
	docker image rm -f ronin:lab ronin:ubuntu

.PHONY: all build ubuntu lab clean
