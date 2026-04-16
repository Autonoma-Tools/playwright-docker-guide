#!/usr/bin/env bash
#
# Debug Playwright tests visually using VNC.
#
# This script builds and runs the Playwright container in headed mode with a
# VNC server so you can watch the browser in real time from any VNC client.
#
# Usage:
#   ./examples/debug-with-vnc.sh
#
# Then connect a VNC viewer to localhost:5900 (no password by default).

set -euo pipefail

IMAGE_NAME="playwright-vnc-debug"
VNC_PORT="${VNC_PORT:-5900}"
DISPLAY_NUM="${DISPLAY_NUM:-99}"

echo "==> Building the Playwright Docker image..."
docker build -t "${IMAGE_NAME}" -f Dockerfile .

echo "==> Starting container with Xvfb + x11vnc on display :${DISPLAY_NUM}..."
echo "    Connect your VNC viewer to localhost:${VNC_PORT}"

docker run --rm -it \
  --ipc=host \
  --init \
  -p "${VNC_PORT}:${VNC_PORT}" \
  -e DISPLAY=":${DISPLAY_NUM}" \
  -v "$(pwd)/tests:/app/tests" \
  -v "$(pwd)/playwright.config.ts:/app/playwright.config.ts" \
  -v "$(pwd)/test-results:/app/test-results" \
  -v "$(pwd)/playwright-report:/app/playwright-report" \
  "${IMAGE_NAME}" \
  bash -c "
    # Start a virtual framebuffer
    Xvfb :${DISPLAY_NUM} -screen 0 1280x720x24 &
    sleep 1

    # Install x11vnc if not already present
    if ! command -v x11vnc &>/dev/null; then
      apt-get update -qq && apt-get install -y -qq x11vnc >/dev/null 2>&1
    fi

    # Start VNC server (no password for local debugging)
    x11vnc -display :${DISPLAY_NUM} -forever -nopw -rfbport ${VNC_PORT} &
    sleep 1

    echo '==> VNC server is running. Connect to localhost:${VNC_PORT}'
    echo '==> Running Playwright in headed mode...'

    # Run tests in headed mode
    npx playwright test --headed
  "

# -----------------------------------------------------------------
# Extracting a trace file after a test run (without VNC):
#
#   CONTAINER_ID=\$(docker run -d --ipc=host --init playwright-tests:latest)
#   docker wait "\${CONTAINER_ID}"
#   docker cp "\${CONTAINER_ID}:/app/test-results" ./test-results
#   docker rm "\${CONTAINER_ID}"
# -----------------------------------------------------------------
