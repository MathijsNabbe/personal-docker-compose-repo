FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y curl tar git sudo unzip libicu-dev libkrb5-3 libcurl4-openssl-dev && \
    apt-get clean

RUN useradd -m -s /bin/bash runner
WORKDIR /home/runner

RUN curl -O -L https://github.com/actions/runner/releases/download/v2.316.0/actions-runner-linux-x64-2.316.0.tar.gz && \
    tar xzf actions-runner-linux-x64-2.316.0.tar.gz && \
    rm actions-runner-linux-x64-2.316.0.tar.gz

COPY entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

USER runner
ENTRYPOINT ["./entrypoint.sh"]
