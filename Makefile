.PHONY: bootstrap build deploy destroy lint


bootstrap:

	bash scripts/bootstrap.sh


build:

	bash scripts/build.sh


deploy:

	bash scripts/deploy.sh demo-123


destroy:

	bash scripts/destroy.sh demo-123


lint:

	helm lint charts/edc-environment