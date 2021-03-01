DOCKER_HUB=roninrb
DOCKER_IMAGE=ronin
ALPINE_VERSION?=latest
UBUNTU_VERSION?=20.04
RONIN_VERSION?=1.5.1

all: build

build: $(DOCKER_IMAGE)\:ubuntu $(DOCKER_IMAGE)\:lab $(DOCKER_IMAGE)\:alpine

$(DOCKER_IMAGE)\:alpine: Dockerfile.alpine
	docker build	-t $(DOCKER_IMAGE):alpine \
			-f Dockerfile.alpine \
			--build-arg ALPINE_VERSION=$(ALPINE_VERSION) \
			--build-arg RONIN_VERSION=$(RONIN_VERSION) \
			.

$(DOCKER_IMAGE)\:ubuntu: Dockerfile.ubuntu
	docker build	-t $(DOCKER_IMAGE):ubuntu \
			-f Dockerfile.ubuntu \
			--build-arg UBUNTU_VERSION=$(UBUNTU_VERSION) \
			--build-arg RONIN_VERSION=$(RONIN_VERSION) \
			.

$(DOCKER_IMAGE)\:lab: $(DOCKER_IMAGE)\:ubuntu Dockerfile.lab
	docker build -t $(DOCKER_IMAGE):lab -f Dockerfile.lab .

$(DOCKER_IMAGE)\:latest:
	docker tag $(DOCKER_IMAGE):lab $(DOCKER_IMAGE):latest

release:
	docker login
	docker tag $(DOCKER_IMAGE):alpine $(DOCKER_HUB)/$(DOCKER_IMAGE):alpine
	docker tag $(DOCKER_IMAGE):ubuntu $(DOCKER_HUB)/$(DOCKER_IMAGE):ubuntu
	docker tag $(DOCKER_IMAGE):lab $(DOCKER_HUB)/$(DOCKER_IMAGE):lab
	docker tag $(DOCKER_IMAGE):latest $(DOCKER_HUB)/$(DOCKER_IMAGE):lab
	docker push $(DOCKER_HUB)/$(DOCKER_IMAGE):alpine
	docker push $(DOCKER_HUB)/$(DOCKER_IMAGE):ubuntu
	docker push $(DOCKER_HUB)/$(DOCKER_IMAGE):lab
	docker push $(DOCKER_HUB)/$(DOCKER_IMAGE):latest

clean:
	docker image rm -f $(DOCKER_IMAGE):{lab,ubuntu,latest}

.PHONY: all build $(DOCKER_IMAGE)\:alpine $(DOCKER_IMAGE)\:ubuntu $(DOCKER_IMAGE)\:lab $(DOCKER_IMAGE)\:latest clean
