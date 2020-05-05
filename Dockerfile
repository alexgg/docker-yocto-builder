ARG UBUNTU_VERSION="latest"
FROM ubuntu:${UBUNTU_VERSION}

MAINTAINER Alex Gonzalez <alex@lindusembedded.com>

# Non-interactive debconf package configuration
ARG DEBIAN_FRONTEND=noninteractive

# Update Ubuntu and Install Yocto Proyect Quick Start dependencies
RUN apt-get update && apt-get install -y locales gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat libsdl1.2-dev xterm cpio curl python python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-jinja2 libegl1-mesa dos2unix sudo && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set bash as default shell
RUN echo "dash dash/sh boolean false" | debconf-set-selections - && dpkg-reconfigure dash

# Set the locale
RUN locale-gen en_US.UTF-8 && \
    dpkg-reconfigure locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8

# Install repo
RUN curl -o /usr/local/bin/repo http://commondatastorage.googleapis.com/git-repo-downloads/repo && chmod a+x /usr/local/bin/repo

# User management
RUN groupadd -g 1000 build && useradd -u 1000 -g 1000 -ms /bin/bash build
RUN echo "build ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER build

RUN echo "echo Welcome to Yocto builder docker image!" >> /home/build/.bashrc
