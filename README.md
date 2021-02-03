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

## Contact

[Slack](https://ronin-rb.slack.com) |
[Discord](https://discord.gg/6WAb3PsVX9) |
[Twitter](https://twitter.com/ronin_rb) |
[IRC](https://ronin-rb.dev/irc/)

[ronin]: https://ronin-rb.dev/
