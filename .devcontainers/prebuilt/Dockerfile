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
RUN curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
