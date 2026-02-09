.PHONY: help install dev lint format test build db-up db-down db-reset clean check

help: ## Show available commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

install: ## Install all dependencies (client + server)
	npm ci
	cd server && npm ci

dev: ## Start client and server dev servers in parallel
	npx concurrently -k -n client,server -c blue,green \
		"npm run dev" \
		"cd server && npm run dev"

lint: ## Lint client and server code
	npm run lint
	cd server && npx eslint .

format: ## Format all code with Prettier
	npx prettier --write .

format-check: ## Check formatting without writing
	npx prettier --check .

build: ## Build client for production
	npm run build

test: ## Run all tests (client + server)
	npx vitest run
	cd server && npx vitest run

db-up: ## Start PostgreSQL container
	docker compose up -d

db-down: ## Stop PostgreSQL container
	docker compose down

db-reset: ## Reset database (destroy data + recreate from schema/seeds)
	docker compose down -v
	docker compose up -d

check: ## Run all checks (lint + format + test + build)
	npm run lint
	cd server && npx eslint .
	npx prettier --check .
	npx vitest run
	cd server && npx vitest run
	npm run build
	@echo "\n\033[32m✓ All checks passed\033[0m"

clean: ## Remove build artifacts and node_modules
	rm -rf dist node_modules server/node_modules
