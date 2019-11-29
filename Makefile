default: help

.PHONY: help
help:
	@echo "dev: build dev container image"

.PHONY: dev
dev:
	docker build -t ankeesler/dev image/dev
	docker push ankeesler/dev
