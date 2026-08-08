#!/bin/bash

set -e

source scripts/lib/common.sh


banner "EDC Kubernetes Platform Bootstrap"


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

    echo "Installing ingress-nginx..."

    helm repo add ingress-nginx \
        https://kubernetes.github.io/ingress-nginx
    helm repo add sealed-secrets \ 
        https://bitnami.github.io/sealed-secrets

    helm repo update


    helm upgrade --install ingress-nginx \
        ingress-nginx/ingress-nginx \
        --namespace ingress-nginx \
        --create-namespace --hide-notes

    helm upgrade --install sealed-secrets \
        sealed-secrets/sealed-secrets \
        --namespace kube-system \
        --create-namespace --hide-notes


else

    echo "Ingress namespace already exists"

fi



echo ""
echo "== Waiting for ingress controller =="


kubectl rollout status \
deployment/ingress-nginx-controller \
-n ingress-nginx \
--timeout=180s



echo ""
echo "== Building application image =="


./scripts/build.sh



echo ""
echo "== Loading image into Kubernetes runtime =="


./scripts/load-image.sh



# echo ""
# echo "== Verifying image availability =="


# IMAGE="edc-demo-web:latest"


# if sudo ctr -n k8s.io images ls | grep -q "edc-demo-web"
# then

#     echo "Image available:"
#     sudo ctr -n k8s.io images ls | grep "edc-demo-web"

# else

#     echo ""
#     echo "ERROR: Image ${IMAGE} not found in Kubernetes runtime"
#     exit 1

# fi



echo ""
echo "===================================="
echo " Bootstrap completed successfully"
echo "===================================="
echo ""
echo "Cluster:"
echo "  READY"
echo ""
echo "Ingress Controller:"
echo "  READY"
echo ""
echo "Application image:"
echo "  ${IMAGE}"
echo ""
echo "Next step:"
echo ""
echo "  ./scripts/deploy.sh <environment-name>"
echo ""
echo "Example:"
echo ""
echo "  ./scripts/deploy.sh demo-123"
echo "  ./scripts/deploy.sh demo-456"
echo ""
echo "===================================="

echo "Verify environments with:"
echo ""

echo "  curl -H \"Host: demo-123.localtest.me\" http://localhost:<INGRESS_NODE_PORT>"
echo ""
echo "  curl -H \"Host: demo-456.localtest.me\" http://localhost:<INGRESS_NODE_PORT>"
echo ""

echo "Replace <INGRESS_NODE_PORT> with the HTTP NodePort from:"
echo ""
echo "  kubectl get svc -n ingress-nginx"
echo ""

echo "===================================="
