all: build

build: ubuntu lab

ubuntu: Dockerfile.ubuntu
	docker build -t ronin:ubuntu -f Dockerfile.ubuntu .

lab: Dockerfile.lab
	docker build -t ronin:lab -f Dockerfile.lab .

clean:
	docker image rm -f ronin:lab
	docker image rm -f ronin:ubuntu

.PHONY: all build ubuntu lab clean
