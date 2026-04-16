FROM mcr.microsoft.com/playwright:v1.52.0-noble

WORKDIR /app

# Copy package files first for better layer caching
COPY package.json package-lock.json ./

# Install dependencies
RUN npm ci

# Copy the rest of the project
COPY . .

# Run Playwright tests
CMD ["npx", "playwright", "test"]
