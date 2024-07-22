DOCKER_HUB=roninrb
DOCKER_IMAGE=ronin
ALPINE_VERSION?=latest
FEDORA_VERSION?=latest
UBUNTU_VERSION?=24.04
RONIN_VERSION?=2.1.0
TAG_VERSION?=$(RONIN_VERSION)

all: build

$(DOCKER_IMAGE)\:alpine: Dockerfile.alpine
	docker build	-t $(DOCKER_IMAGE):$(TAG_VERSION)-alpine \
			-f Dockerfile.alpine \
			--build-arg ALPINE_VERSION=$(ALPINE_VERSION) \
			--build-arg RONIN_VERSION=$(RONIN_VERSION) \
			.
	docker tag $(DOCKER_IMAGE):$(TAG_VERSION)-alpine $(DOCKER_IMAGE):alpine

build_alpine: $(DOCKER_IMAGE)\:alpine

run_alpine: $(DOCKER_IMAGE)\:alpine
	docker run --rm -it $(DOCKER_IMAGE):alpine

$(DOCKER_IMAGE)\:fedora: Dockerfile.fedora
	docker build	-t $(DOCKER_IMAGE):$(TAG_VERSION)-fedora \
			-f Dockerfile.fedora \
			--build-arg FEDORA_VERSION=$(FEDORA_VERSION) \
			--build-arg RONIN_VERSION=$(RONIN_VERSION) \
			.
	docker tag $(DOCKER_IMAGE):$(TAG_VERSION)-fedora $(DOCKER_IMAGE):fedora

build_fedora: $(DOCKER_IMAGE)\:fedora

run_fedora: $(DOCKER_IMAGE)\:fedora
	docker run --rm -it $(DOCKER_IMAGE):fedora

$(DOCKER_IMAGE)\:ubuntu: Dockerfile.ubuntu
	docker build	-t $(DOCKER_IMAGE):$(TAG_VERSION)-ubuntu \
			-f Dockerfile.ubuntu \
			--build-arg UBUNTU_VERSION=$(UBUNTU_VERSION) \
			--build-arg RONIN_VERSION=$(RONIN_VERSION) \
			.
	docker tag $(DOCKER_IMAGE):$(TAG_VERSION)-ubuntu $(DOCKER_IMAGE):ubuntu

build_ubuntu: $(DOCKER_IMAGE)\:ubuntu

run_ubuntu: $(DOCKER_IMAGE)\:ubuntu
	docker run --rm -it $(DOCKER_IMAGE):ubuntu

$(DOCKER_IMAGE)\:lab: $(DOCKER_IMAGE)\:ubuntu Dockerfile.lab
	docker build -t $(DOCKER_IMAGE):$(TAG_VERSION)-lab -f Dockerfile.lab .
	docker tag $(DOCKER_IMAGE):$(TAG_VERSION)-lab $(DOCKER_IMAGE):lab

build_lab: $(DOCKER_IMAGE)\:lab

run_lab: $(DOCKER_IMAGE)\:lab
	docker run --rm -it $(DOCKER_IMAGE):lab

$(DOCKER_IMAGE)\:latest: $(DOCKER_IMAGE)\:ubuntu
	docker tag $(DOCKER_IMAGE):ubuntu $(DOCKER_IMAGE):latest

build: build_ubuntu build_alpine build_fedora build_lab

release: $(DOCKER_IMAGE)\:alpine $(DOCKER_IMAGE)\:fedora $(DOCKER_IMAGE)\:ubuntu $(DOCKER_IMAGE)\:lab $(DOCKER_IMAGE)\:latest
	docker login
	docker tag $(DOCKER_IMAGE):$(TAG_VERSION)-alpine $(DOCKER_HUB)/$(DOCKER_IMAGE):$(TAG_VERSION)-alpine
	docker tag $(DOCKER_IMAGE):$(TAG_VERSION)-fedora $(DOCKER_HUB)/$(DOCKER_IMAGE):$(TAG_VERSION)-fedora
	docker tag $(DOCKER_IMAGE):$(TAG_VERSION)-ubuntu $(DOCKER_HUB)/$(DOCKER_IMAGE):$(TAG_VERSION)-ubuntu
	docker tag $(DOCKER_IMAGE):$(TAG_VERSION)-lab $(DOCKER_HUB)/$(DOCKER_IMAGE):$(TAG_VERSION)-lab
	docker tag $(DOCKER_IMAGE):$(TAG_VERSION)-ubuntu $(DOCKER_HUB)/$(DOCKER_IMAGE):$(TAG_VERSION)
	docker push $(DOCKER_HUB)/$(DOCKER_IMAGE):$(TAG_VERSION)-alpine
	docker push $(DOCKER_HUB)/$(DOCKER_IMAGE):$(TAG_VERSION)-fedora
	docker push $(DOCKER_HUB)/$(DOCKER_IMAGE):$(TAG_VERSION)-ubuntu
	docker push $(DOCKER_HUB)/$(DOCKER_IMAGE):$(TAG_VERSION)-lab
	docker push $(DOCKER_HUB)/$(DOCKER_IMAGE):$(TAG_VERSION)
	if [[ ! "${RONIN_VERSION}" == *rc* ]] && \
	   [[ ! "${RONIN_VERSION}" == *pre* ]] && \
	   [[ ! "${RONIN_VERSION}" == *beta* ]] && \
	   [[ ! "${RONIN_VERSION}" == *alpha* ]]; then \
		docker tag $(DOCKER_IMAGE):alpine $(DOCKER_HUB)/$(DOCKER_IMAGE):alpine; \
		docker tag $(DOCKER_IMAGE):fedora $(DOCKER_HUB)/$(DOCKER_IMAGE):fedora; \
		docker tag $(DOCKER_IMAGE):ubuntu $(DOCKER_HUB)/$(DOCKER_IMAGE):ubuntu; \
		docker tag $(DOCKER_IMAGE):lab $(DOCKER_HUB)/$(DOCKER_IMAGE):lab; \
		docker tag $(DOCKER_IMAGE):latest $(DOCKER_HUB)/$(DOCKER_IMAGE):latest; \
		docker push $(DOCKER_HUB)/$(DOCKER_IMAGE):alpine; \
		docker push $(DOCKER_HUB)/$(DOCKER_IMAGE):fedora; \
		docker push $(DOCKER_HUB)/$(DOCKER_IMAGE):ubuntu; \
		docker push $(DOCKER_HUB)/$(DOCKER_IMAGE):lab; \
		docker push $(DOCKER_HUB)/$(DOCKER_IMAGE):latest; \
	fi
	docker logout
	git tag v$(TAG_VERSION)
	git push origin $(git branch --show)
	git push --tags origin

clean:
	docker image rm -f $(DOCKER_IMAGE):{$(TAG_VERSION)-,}{fedora,ubuntu,lab,latest}

.PHONY: all build build_alpine run_alpine build_fedora run_fedora build_ubuntu run_ubuntu build_lab run_lab tag_latest $(DOCKER_IMAGE)\:alpine $(DOCKER_IMAGE)\:fedora $(DOCKER_IMAGE)\:ubuntu $(DOCKER_IMAGE)\:lab $(DOCKER_IMAGE)\:latest clean
