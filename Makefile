DOCKER_HUB=roninrb
UBUNTU_VERSION=20.04
RONIN_VERSION=1.5.0

all: build

build: ronin\:ubuntu ronin\:lab

ronin\:ubuntu: Dockerfile.ubuntu
	docker build	-t ronin:ubuntu \
			-f Dockerfile.ubuntu \
			--build-arg UBUNTU_VERSION=$(UBUNTU_VERSION) \
			--build-arg RONIN_VERSION=$(RONIN_VERSION) \
			.

ronin\:lab: ronin\:ubuntu Dockerfile.lab
	docker build -t ronin:lab -f Dockerfile.lab .

release:
	docker login
	docker tag ronin:ubuntu $(DOCKER_HUB)/ronin:ubuntu
	docker tag ronin:lab $(DOCKER_HUB)/ronin:lab
	docker tag ronin:latest $(DOCKER_HUB)/ronin:lab
	docker push $(DOCKER_HUB)/ronin:ubuntu
	docker push $(DOCKER_HUB)/ronin:lab
	docker push $(DOCKER_HUB)/ronin:latest

clean:
	docker image rm -f ronin:lab ronin:ubuntu

.PHONY: all build ronin\:ubuntu ronin\:lab clean
