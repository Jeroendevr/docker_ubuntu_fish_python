FROM ubuntu:latest

# TimeZone is needed otherwise config needs to happen during build
ENV TZ=Europe/Amsterdam
# Locales are needed otherwise a lot of errors pop up

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone

# Install usefull tools
RUN apt-get -y update && \
    apt-get install -y \
    tree \
    git 

# Add Fish Shell Repo
# https://stackoverflow.com/q/32486779/4465153
RUN apt-get install -y software-properties-common && \
    apt-add-repository -y ppa:fish-shell/release-3 && \
    apt-get install -y fish

# Install python build dependencies for Pyenv 
# https://github.com/pyenv/pyenv/#install-python-build-dependencies
RUN apt-get -y install \
    make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    curl \
    llvm \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev 

# Sanity 
RUN apt-get -y autoclean

# Switch to Fish Shell
SHELL ["fish", "--command"]
RUN chsh -s /usr/bin/fish

# PyEnv installation
# https://github.com/pyenv/pyenv#basic-github-checkout
RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv
ENV PYENV_ROOT /root/.pyenv
ENV PATH ${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:$PATH
RUN pyenv install 3.10