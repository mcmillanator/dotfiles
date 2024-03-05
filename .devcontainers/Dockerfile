FROM python:3.12
WORKDIR /tmp
RUN adduser dev && \
  mkdir /src && \
  chown dev /src
USER dev
WORKDIR /src
RUN pip install pipenv
ENV PATH=$PATH:/home/dev/.local/bin
CMD ["sleep","infinity"]
