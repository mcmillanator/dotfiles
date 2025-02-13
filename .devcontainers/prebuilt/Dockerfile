ARG IMAGE=ubuntu:22.04
FROM ${IMAGE} as base
RUN apt-get update && \
# dependencies for rest.nvim https://github.com/rest-nvim/rest.nvim?tab=readme-ov-file#install
  apt-get install --no-install-recommends -y ca-certificates \
  curl \
  gcc \
  git \
  libcurlpp-dev \
  lua5.4 \
  luarocks \
  tmux \
  && \
  rm -rf /var/lib/apt/lists/* && \
  luarocks install lua-curl CURL_INCDIR=/usr/include/x86_64-linux-gnu/
ENV CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz && \
  rm -rf /opt/nvim && \
  tar -C /opt -xzf nvim-linux64.tar.gz
ENV PATH=$PATH:/opt/nvim-linux64/bin
RUN curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
