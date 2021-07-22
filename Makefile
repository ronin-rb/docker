DOCKER_HUB=roninrb
DOCKER_IMAGE=ronin
ALPINE_VERSION?=latest
UBUNTU_VERSION?=20.04
RONIN_VERSION?=1.5.1

all: build

build: build_ubuntu build_lab build_alpine

$(DOCKER_IMAGE)\:alpine: Dockerfile.alpine
	docker build	-t $(DOCKER_IMAGE):alpine \
			-f Dockerfile.alpine \
			--build-arg ALPINE_VERSION=$(ALPINE_VERSION) \
			--build-arg RONIN_VERSION=$(RONIN_VERSION) \
			.

build_alpine: $(DOCKER_IMAGE)\:alpine

run_alpine: $(DOCKER_IMAGE)\:alpine
	docker run -it $(DOCKER_IMAGE):alpine

$(DOCKER_IMAGE)\:ubuntu: Dockerfile.ubuntu
	docker build	-t $(DOCKER_IMAGE):ubuntu \
			-f Dockerfile.ubuntu \
			--build-arg UBUNTU_VERSION=$(UBUNTU_VERSION) \
			--build-arg RONIN_VERSION=$(RONIN_VERSION) \
			.

build_ubuntu: $(DOCKER_IMAGE)\:ubuntu

run_ubuntu: $(DOCKER_IMAGE)\:ubuntu
	docker run -it $(DOCKER_IMAGE):ubuntu

$(DOCKER_IMAGE)\:lab: $(DOCKER_IMAGE)\:ubuntu Dockerfile.lab
	docker build -t $(DOCKER_IMAGE):lab -f Dockerfile.lab .

build_lab: $(DOCKER_IMAGE)\:lab

run_lab: $(DOCKER_IMAGE)\:lab
	docker run -it $(DOCKER_IMAGE):lab

$(DOCKER_IMAGE)\:latest: $(DOCKER_IMAGE)\:lab
	docker tag $(DOCKER_IMAGE):lab $(DOCKER_IMAGE):latest

tag_latest: $(DOCKER_IMAGE)\:latest $(DOCKER_IMAGE)\:ubuntu

release: $(DOCKER_IMAGE)\:alpine $(DOCKER_IMAGE)\:ubuntu $(DOCKER_IMAGE)\:lab
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

.PHONY: all build build_alpine run_alpine build_ubuntu run_ubuntu build_lab run_lab tag_latest $(DOCKER_IMAGE)\:alpine $(DOCKER_IMAGE)\:ubuntu $(DOCKER_IMAGE)\:lab $(DOCKER_IMAGE)\:latest clean
