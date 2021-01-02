ARG UBUNTU_VERSION=20.04
FROM ubuntu:${UBUNTU_VERSION}

RUN apt-get update -qq

# Install external dependencies
RUN apt-get install -qq -y gcc make ruby-full libreadline-dev libsqlite3-dev libxml2-dev libxslt1-dev

# Install ronin
RUN gem install ronin

RUN useradd -m -s /bin/bash ronin

USER ronin
WORKDIR /home/ronin

ARG LANG=en_US.UTF-8
ENV LANG=${LANG}

CMD ["/bin/bash"]
