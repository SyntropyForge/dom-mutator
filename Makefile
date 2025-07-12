# Default target - show help
.DEFAULT_GOAL := help

# Version bump type (patch, minor, major)
BUMP ?= patch

# Show help
help:
	@echo "Available commands:"
	@echo "  make help        - Show this help message"
	@echo "  make prod-push   - Build and publish package to GitHub Packages"
	@echo ""
	@echo "Version bump options:"
	@echo "  make prod-push BUMP=patch  - Bump patch version (default)"
	@echo "  make prod-push BUMP=minor  - Bump minor version"
	@echo "  make prod-push BUMP=major  - Bump major version"

# Build and publish to GitHub Packages
prod-push:
	NPM_AUTH_TOKEN=$$(cat .npm_token) yarn install && \
	NPM_AUTH_TOKEN=$$(cat .npm_token) yarn build && \
	npm version $(BUMP) --no-git-tag-version && \
	NPM_AUTH_TOKEN=$$(cat .npm_token) npm publish --registry=https://npm.pkg.github.com 