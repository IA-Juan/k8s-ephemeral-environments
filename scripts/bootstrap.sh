#!/bin/bash


source scripts/lib/common.sh


banner "EDC Environment Bootstrap"



check_command kubectl

check_command helm

check_command docker



echo "Kubernetes:"

kubectl version --short || true


echo ""

echo "Helm:"

helm version



echo ""

echo "Docker:"

docker version --format '{{.Server.Version}}'


echo ""

echo "Bootstrap completed"