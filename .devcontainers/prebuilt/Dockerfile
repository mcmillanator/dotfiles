ARG IMAGE=ubuntu:22.04
FROM ${IMAGE}
RUN apt-get update && \
  apt-get install --no-install-recommends -y ca-certificates \
  cmake \
  curl \
  fd-find \
  gcc \
  git \
  libcurlpp-dev \
  lua5.4 \
  luarocks \
  make \
  pinentry-tty \
  && \
  rm -rf /var/lib/apt/lists/* && \
  luarocks install lua-curl CURL_INCDIR=/usr/include/x86_64-linux-gnu/
ENV CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
RUN wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz && \
  rm -rf /opt/nvim && \
  tar -C /opt -xzf nvim-linux-x86_64.tar.gz && \
  rm nvim-linux-x86_64.tar.gz
ENV PATH=$PATH:/opt/nvim-linux-x86_64/bin
RUN curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
