.PHONY: help build debug

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: ## Build an CentOS virtual machine appliance
	packer build templates/specchio_centos7.5_virtualbox.json

debug: ## Build an CentOS virtual machine appliance with debug flags
	packer build -debug -on-error ask templates/specchio_centos7.5_virtualbox.json