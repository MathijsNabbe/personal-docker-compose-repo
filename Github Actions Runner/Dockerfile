FROM ubuntu:22.04

# Update and install dependencies, including build-essential and libyaml-dev
RUN apt-get update && \
    apt-get install -y \
    curl \
    tar \
    git \
    unzip \
    libicu-dev \
    libkrb5-3 \
    libcurl4-openssl-dev \
    libyaml-dev \
    build-essential && \
    apt-get clean

# Create runner user and ensure the directories have the correct ownership
RUN useradd -m -s /bin/bash runner
RUN mkdir -p /opt/hostedtoolcache /home/runner/_work && \
    chown -R runner:runner /opt/hostedtoolcache /home/runner

WORKDIR /home/runner

# Download and extract GitHub Actions runner
RUN curl -O -L https://github.com/actions/runner/releases/download/v2.316.0/actions-runner-linux-x64-2.316.0.tar.gz && \
    tar xzf actions-runner-linux-x64-2.316.0.tar.gz && \
    rm actions-runner-linux-x64-2.316.0.tar.gz

# Copy and set entrypoint script
COPY entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

# Set runner user
USER runner

# Install the specific Bundler version for Ruby 2.7
RUN gem install bundler -v 2.4.22

# Set entrypoint
ENTRYPOINT ["./entrypoint.sh"]
