ARG UBUNTU_VERSION=20.04
FROM ubuntu:${UBUNTU_VERSION}

LABEL maintainer="postmodern.mod3@gmail.com"

ARG LANG=en_US.UTF-8
ENV LANG=${LANG}
ENV LANGUAGE=${LANG}
ENV LC_ALL=${LANG}

ARG TZ=UTC
ENV TZ=${TZ}

RUN apt-get update -qq

RUN apt-get install -qq -y locales && \
    locale-gen "${LANG%.*}" "$LANG" && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale

RUN apt-get install -qq -y tzdata && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    dpkg-reconfigure --frontend=noninteractive tzdata

# Install external dependencies
RUN apt-get install -qq -y gcc make ruby-full libreadline-dev libsqlite3-dev libxml2-dev libxslt1-dev

# Install ronin
RUN gem install ronin

# Re-add common core utils
RUN apt-get install -qq -y tar zip vim netstat-nat net-tools iputils-ping traceroute host whois netcat wget curl git

RUN useradd -m -s /bin/bash ronin && \
    apt-get install -qq -y sudo && \
    echo "ronin ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/ronin && \
    chmod 0440 /etc/sudoers.d/ronin && \
    usermod -aG sudo ronin && \
    touch /home/ronin/.sudo_as_admin_successful && \
    chown ronin:ronin /home/ronin/.sudo_as_admin_successful

USER ronin
WORKDIR /home/ronin

CMD ["/bin/bash"]
