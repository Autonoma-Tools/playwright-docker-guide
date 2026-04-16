#!/usr/bin/env bash
#
# Build and run Playwright tests in headless mode using the basic Dockerfile.
#
# Usage:
#   ./examples/run-headless.sh
#
# Test results and the HTML report are written to ./test-results and
# ./playwright-report on the host via bind mounts.

set -euo pipefail

IMAGE_NAME="playwright-tests"

echo "==> Building the Playwright Docker image..."
docker build -t "${IMAGE_NAME}" -f Dockerfile .

echo "==> Running Playwright tests (headless)..."
docker run --rm \
  --ipc=host \
  --init \
  -v "$(pwd)/test-results:/app/test-results" \
  -v "$(pwd)/playwright-report:/app/playwright-report" \
  "${IMAGE_NAME}"

echo "==> Done. Check ./playwright-report/index.html for the full report."
