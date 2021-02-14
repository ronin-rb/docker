IMAGES=ubuntu lab

all: build

build: ubuntu lab

ubuntu: Dockerfile.ubuntu
	docker build -t ronin:ubuntu -f Dockerfile.ubuntu .

lab: Dockerfile.lab
	docker build -t ronin:lab -f Dockerfile.lab .

.PHONY: all build ubuntu lab
