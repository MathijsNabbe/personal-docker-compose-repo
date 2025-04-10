FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl git wget unzip sudo gnupg2 build-essential libffi-dev libyaml-dev \
    libgdbm-dev libncurses5-dev libtool bison libssl-dev libreadline-dev \
    zlib1g-dev libgmp-dev libgdbm-compat-dev software-properties-common \
    ruby-full ruby-dev nodejs npm openjdk-17-jre-headless \
    && rm -rf /var/lib/apt/lists/*

# Install Ruby
RUN apt-get update && apt-get install -y \
    ruby-full \
    ruby-dev \
    build-essential \
    zlib1g-dev

# Install Jekyll and Bundler
RUN gem install bundler jekyll

# Install SonarScanner
ENV SONAR_SCANNER_VERSION=5.0.1.3006
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip && \
    unzip sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip && \
    mv sonar-scanner-${SONAR_SCANNER_VERSION}-linux /opt/sonar-scanner && \
    ln -s /opt/sonar-scanner/bin/sonar-scanner /usr/local/bin/sonar-scanner && \
    rm sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip

ENV PATH="${PATH}:/opt/sonar-scanner/bin"

# Add a user for the GitHub runner
RUN useradd -m -s /bin/bash runner

# Give the runner user ownership of required directories
RUN mkdir -p /var/lib/gems && \
    chown -R runner:runner /var/lib/gems && \
    chown -R runner:runner /usr/local/bin

# Copy entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Switch to runner user
USER runner
WORKDIR /home/runner

ENTRYPOINT ["/entrypoint.sh"]
