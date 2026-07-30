#!/bin/bash

set -e

source scripts/lib/common.sh


NAMESPACE=${1:-demo-123}


banner "EDC Environment Bootstrap"


echo "Using namespace: ${NAMESPACE}"


echo ""
echo "== Checking commands =="

check_command kubectl
check_command helm
check_command docker


echo ""
echo "== Kubernetes =="

kubectl get nodes


echo ""
echo "== Installing ingress-nginx =="

if ! kubectl get namespace ingress-nginx >/dev/null 2>&1
then

  helm repo add ingress-nginx \
    https://kubernetes.github.io/ingress-nginx

  helm repo update


  helm upgrade --install ingress-nginx \
    ingress-nginx/ingress-nginx \
    --namespace ingress-nginx \
    --create-namespace

else

  echo "Ingress namespace already exists"

fi



echo ""
echo "== Building application image =="

./scripts/build.sh



echo ""
echo "== Loading image =="

./scripts/load-image.sh



echo ""
echo "== Deploying environment =="

./scripts/deploy.sh ${NAMESPACE}



echo ""
echo "== Waiting for application =="


kubectl rollout status \
deployment/${NAMESPACE}-web \
-n ${NAMESPACE} \
--timeout=180s



echo ""
echo "== Final status =="

kubectl get pods -n ${NAMESPACE}


echo ""

echo "Bootstrap completed successfully"