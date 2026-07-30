.PHONY: help build deploy destroy lint clean

help:
	@echo "Available commands:"
	@echo ""
	@echo "make build   - Build application image"
	@echo "make deploy  - Deploy Kubernetes environment"
	@echo "make destroy - Remove Kubernetes environment"
	@echo "make lint    - Validate Helm chart"
	@echo "make clean   - Clean temporary files"


build:
	./scripts/build.sh


deploy:
	./scripts/deploy.sh


destroy:
	./scripts/destroy.sh


lint:
	helm lint charts/edc-environment


clean:
	rm -rf tmp/