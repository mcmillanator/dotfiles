ARG IMAGE=ubuntu:22.04
FROM ${IMAGE}
RUN apt-get update && \
# dependencies for rest.nvim https://github.com/rest-nvim/rest.nvim?tab=readme-ov-file#install
  apt-get install --no-install-recommends -y ca-certificates \
  # needed to compile tmux
  byacc \
  curl \
  fd-find \
  gcc \
  git \
  libcurlpp-dev \
  # needed to compile tmux
  libevent-dev \
  lua5.4 \
  luarocks \
  && \
  rm -rf /var/lib/apt/lists/* && \
  luarocks install lua-curl CURL_INCDIR=/usr/include/x86_64-linux-gnu/
ENV CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz && \
# TODO: stop building tmux from source once image has version 3.4 or later
# 3.4 or later is requied for fzf --tmux to work
RUN wget https://github.com/tmux/tmux/releases/download/3.5a/tmux-3.5a.tar.gz && \
  tar -zxf tmux-*.tar.gz && \
  cd tmux-*/ && \
  ./configure && \
  make && make install && \
  cd .. && rm -rf tmux-*
  rm -rf /opt/nvim && \
  tar -C /opt -xzf nvim-linux64.tar.gz
ENV PATH=$PATH:/opt/nvim-linux64/bin
RUN curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
