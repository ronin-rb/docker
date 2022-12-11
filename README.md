# Docker

* [Website](https://ronin-rb.dev)
* [Issues](https://github.com/ronin-rb/docker/issues)
* [DockerHub](https://hub.docker.com/r/roninrb/ronin)
* [Slack](https://ronin-rb.slack.com) |
  [Discord](https://discord.gg/6WAb3PsVX9) |
  [Twitter](https://twitter.com/ronin_rb)

This repository provides `Dockerfile`s to build images with the [ronin] gems
pre-installed.

## Images

* [ronin:alpine] - a base `alpine:latest` image with [ronin gem] installed.
* [ronin:fedora] - a base `fedora:latest` image with [ronin gem] installed.
* [ronin:ubuntu] - a base `ubuntu:20.04` image with [ronin gem] installed.
* [ronin:lab] - like `ronin:ubuntu` but with additional tools installed.
* [ronin:latest][ronin:lab] - alias for `ronin:lab`.

## Pull

```shell
docker pull roninrb/ronin
```

## Build

Build all images:

```shell
make build
```

Build only one image:

```shell
make ronin:lab
```

## Run

```shell
docker run -it ronin:lab
```

With your home-dir mounted:

```shell
docker run -it --mount type=bind,source="$HOME",target=/home/ronin ronin:lab
```

[ronin]: https://ronin-rb.dev/
[ronin gem]: https://rubygems.org/gems/ronin

[ronin:alpine]: https://github.com/ronin-rb/docker/blob/main/Dockerfile.alpine
[ronin:fedora]: https://github.com/ronin-rb/docker/blob/main/Dockerfile.fedora
[ronin:ubuntu]: https://github.com/ronin-rb/docker/blob/main/Dockerfile.ubuntu
[ronin:lab]: https://github.com/ronin-rb/docker/blob/main/Dockerfile.lab
