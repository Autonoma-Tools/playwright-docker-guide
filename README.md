# Playwright Docker: Stop Chasing Missing Browser Libraries in CI

Companion code for the Autonoma blog post [Playwright Docker: Stop Chasing Missing Browser Libraries in CI](https://getautonoma.com/blog/playwright-docker-guide).

> Companion code for the Autonoma blog post: **[Playwright Docker: Stop Chasing Missing Browser Libraries in CI](https://getautonoma.com/blog/playwright-docker-guide)**

## Requirements

- Docker 20.10+
- Node.js 18+ (for local development only)
- A VNC viewer (optional, for visual debugging with `examples/debug-with-vnc.sh`)

## Quickstart

```bash
# Clone the repo
git clone https://github.com/Autonoma-Tools/playwright-docker-guide.git
cd playwright-docker-guide

# Option 1: Run with Docker Compose (includes a sample webapp)
docker compose up

# Option 2: Build and run the basic Dockerfile directly
docker build -t playwright-tests .
docker run --ipc=host --init playwright-tests

# Option 3: Run locally (requires Node 18+ and browsers installed)
npm install
npx playwright install
npm test
```

## Project structure

```
.dockerignore
.github/
  workflows/
    e2e.yml
.gitignore
.gitlab-ci.yml
Dockerfile
Dockerfile.production
LICENSE
README.md
docker-compose.yml
examples/
  debug-with-vnc.sh
  run-headless.sh
package.json
playwright.config.ts
tests/
  example.spec.ts
```

- `examples/` — runnable examples you can execute as-is.
- `tests/` — sample Playwright test specs.
- `.github/workflows/` — GitHub Actions CI configuration.

## About

This repository is maintained by [Autonoma](https://getautonoma.com) as reference material for the linked blog post. Autonoma builds autonomous AI agents that plan, execute, and maintain end-to-end tests directly from your codebase.

If something here is wrong, out of date, or unclear, please [open an issue](https://github.com/Autonoma-Tools/playwright-docker-guide/issues/new).

## License

Released under the [MIT License](./LICENSE) © 2026 Autonoma Labs.
