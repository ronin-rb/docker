# Docker

This repository provides a `Dockerfile` to build an image with [ronin]
pre-installed.

## Build

```shell
docker build -t ronin .
```

## Run (with home-dir)

```shell
docker run -it --mount type=bind,source="$HOME",target=/home/ubuntu ronin:latest
```

[ronin]: https://ronin-rb.dev/
