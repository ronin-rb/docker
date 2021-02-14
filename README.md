# Docker

This repository provides a `Dockerfile` to build an image with [ronin]
pre-installed.

## Images

* `ronin:ubuntu` - A base ubuntu 20.04 image with ronin gems installed.
* `ronin:lab` - Like `ronin:ubuntu` but with additional tools installed.

## Build

```shell
make build
```

## Run

```shell
docker run -it ronin:lab
```

With your home-dir mounted:

```shell
docker run -it --mount type=bind,source="$HOME",target=/home/ronin ronin:lab
```

## Contact

[Slack](https://ronin-rb.slack.com) |
[Discord](https://discord.gg/6WAb3PsVX9) |
[Twitter](https://twitter.com/ronin_rb) |
[IRC](https://ronin-rb.dev/irc/)

[ronin]: https://ronin-rb.dev/
