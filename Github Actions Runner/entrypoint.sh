#!/bin/bash
set -e

if [ -z "$REPO_URL" ] || [ -z "$RUNNER_TOKEN" ]; then
  echo "REPO_URL and RUNNER_TOKEN must be set"
  exit 1
fi

cd /home/runner

# Download and extract runner
RUNNER_VERSION="2.317.0"
RUNNER_ARCHIVE="actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz"
RUNNER_DIR="actions-runner"

if [ ! -d "$RUNNER_DIR" ]; then
  echo "Downloading GitHub Actions runner..."
  curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/${RUNNER_ARCHIVE}
  mkdir "$RUNNER_DIR"
  tar -xzf ${RUNNER_ARCHIVE} -C "$RUNNER_DIR"
  rm ${RUNNER_ARCHIVE}
fi

cd "$RUNNER_DIR"

# Remove old runner
./config.sh remove

# Configure the runner
./config.sh --unattended \
  --url "$REPO_URL" \
  --token "$RUNNER_TOKEN" \
  --name "Custom Jekyll Runner" \
  --work _work \
  --labels self-hosted,jekyll,sonar

# Run the runner
exec ./run.sh
