DOCKER_HUB=roninrb

all: build

build: ronin

ronin: ronin\:ubuntu ronin\:lab

ronin\:ubuntu: ronin/Dockerfile.ubuntu
	docker build -t ronin:ubuntu -f ronin/Dockerfile.ubuntu .

ronin\:lab: ronin\:ubuntu ronin/Dockerfile.lab
	docker build -t ronin:lab -f ronin/Dockerfile.lab .

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

.PHONY: all build ronin ronin\:ubuntu ronin\:lab clean
