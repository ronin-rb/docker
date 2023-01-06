# Docker

* [Website](https://ronin-rb.dev)
* [Issues](https://github.com/ronin-rb/docker/issues)
* [DockerHub](https://hub.docker.com/r/roninrb/ronin)
* [Discord](https://discord.gg/6WAb3PsVX9) |
  [Twitter](https://twitter.com/ronin_rb) |
  [Mastodon](https://infosec.exchange/@ronin_rb)

This repository provides `Dockerfile`s to build images with the [ronin] gems
pre-installed.

## What is Ronin?

[Ronin][ronin] is a free and Open Source [Ruby] toolkit for security research
and development. Ronin contains many different [CLI commands][Synopsis] and
[Ruby libraries][GitHub] for a variety of security tasks, such as
encoding/decoding data, filter IPs/hosts/URLs, querying ASNs, querying DNS,
HTTP, scanning for web vulnerabilities, spidering websites, install 3rd party
repositories of exploits and/or payloads, run exploits, generating new exploits,
managing local databases, fuzzing data, and much more.

## Images

* [ronin:2.0.0.beta1-ubuntu, ronin:ubuntu, ronin:latest][ronin:ubuntu] -
  a base `ubuntu:22.04` image with [ronin gem] installed.
* [ronin:2.0.0.beta1-alpine, ronin:alpine][ronin:alpine] -
  a base `alpine:latest` image with [ronin gem] installed.
* [ronin:2.0.0.beta1-fedora, ronin:fedora][ronin:fedora] -
  a base `fedora:latest` image with [ronin gem] installed.
* [ronin:2.0.0.beta1-lab, ronin:lab][ronin:lab] -
  similar to [ronin:ubuntu] but with additional tools installed.

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
[Ruby]: https://www.ruby-lang.org/
[Synopsis]: https://github.com/ronin-rb/ronin#synopsis
[GitHub]: https://github.com/ronin-rb/
[ronin gem]: https://rubygems.org/gems/ronin

[ronin:alpine]: https://github.com/ronin-rb/docker/blob/main/Dockerfile.alpine
[ronin:fedora]: https://github.com/ronin-rb/docker/blob/main/Dockerfile.fedora
[ronin:ubuntu]: https://github.com/ronin-rb/docker/blob/main/Dockerfile.ubuntu
[ronin:lab]: https://github.com/ronin-rb/docker/blob/main/Dockerfile.lab
