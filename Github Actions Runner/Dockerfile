FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y curl tar git unzip libicu-dev libkrb5-3 libcurl4-openssl-dev && \
    apt-get clean

# Create runner user and ensure the directories have the correct ownership
RUN useradd -m -s /bin/bash runner
RUN mkdir -p /opt/hostedtoolcache /home/runner/_work && \
    chown -R runner:runner /opt/hostedtoolcache /home/runner

WORKDIR /home/runner

RUN curl -O -L https://github.com/actions/runner/releases/download/v2.316.0/actions-runner-linux-x64-2.316.0.tar.gz && \
    tar xzf actions-runner-linux-x64-2.316.0.tar.gz && \
    rm actions-runner-linux-x64-2.316.0.tar.gz

COPY entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

# Set runner user
USER runner

ENTRYPOINT ["./entrypoint.sh"]
