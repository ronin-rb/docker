ARG UBUNTU_VERSION=20.04
FROM ubuntu:${UBUNTU_VERSION}

ARG LANG=en_US.UTF-8
ENV LANG=${LANG}

ARG TZ=GMT
ENV TZ=${TZ}

RUN apt-get update -qq

RUN apt-get install -qq -y tzdata && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    dpkg-reconfigure --frontend=noninteractive tzdata

# Re-add common core utils
RUN apt-get install -qq -y tar zip vim netstat-nat net-tools iputils-ping traceroute host whois netcat wget curl git

# Install external dependencies
RUN apt-get install -qq -y gcc make ruby-full libreadline-dev libsqlite3-dev libxml2-dev libxslt1-dev

# Install ronin
RUN gem install ronin

RUN useradd -m -s /bin/bash ronin

RUN apt-get install -qq -y sudo
RUN echo "ronin ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/ronin && \
    chmod 0440 /etc/sudoers.d/ronin
RUN usermod -aG sudo ronin
RUN touch /home/ronin/.sudo_as_admin_successful
RUN chown ronin:ronin /home/ronin/.sudo_as_admin_successful

USER ronin
WORKDIR /home/ronin

CMD ["/bin/bash"]
