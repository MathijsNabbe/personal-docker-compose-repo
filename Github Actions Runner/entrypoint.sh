#!/bin/bash

echo "Configuring GitHub Actions Runner..."

./config.sh \
  --url "$REPO_URL" \
  --token "$RUNNER_TOKEN" \
  --name "$RUNNER_NAME" \
  --work "_work" \
  --unattended \
  --replace

cleanup() {
  echo "Removing runner..."
  ./config.sh remove --unattended --token "$RUNNER_TOKEN"
  exit 0
}

chown -R runner:runner /home/runner/_work

trap cleanup SIGINT SIGTERM

echo "Starting runner..."
./run.sh
