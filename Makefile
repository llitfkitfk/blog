.DEFAULT_GOAL := help

.PHONY: dev
dev: ## build react-native
	open http://localhost:1313
	hugo server -D -w
	


.PHONY: help
help: ## list command
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)