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
echo "== Waiting for ingress controller =="


kubectl rollout status \
deployment/ingress-nginx-controller \
-n ingress-nginx \
--timeout=180s



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
echo "== Creating ingress =="


cat <<EOF | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ${NAMESPACE}-ingress
  namespace: ${NAMESPACE}
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  rules:
  - http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: ${NAMESPACE}-web
            port:
              number: 80
EOF



echo ""
echo "== Checking ingress =="

kubectl get ingress -n ${NAMESPACE}



echo ""
echo "== Final status =="

kubectl get pods -n ${NAMESPACE}



echo ""
echo "== Detecting external access =="


SERVICE_TYPE=$(kubectl get svc ingress-nginx-controller \
-n ingress-nginx \
-o jsonpath='{.spec.type}')



if [ "${SERVICE_TYPE}" = "LoadBalancer" ]
then

    EXTERNAL_IP=$(kubectl get svc ingress-nginx-controller \
    -n ingress-nginx \
    -o jsonpath='{.status.loadBalancer.ingress[0].ip}')


    if [ -n "${EXTERNAL_IP}" ]
    then

        echo ""
        echo "LoadBalancer detected"
        echo ""
        echo "Access URL:"
        echo "http://${EXTERNAL_IP}"

    else

        NODE_PORT=$(kubectl get svc ingress-nginx-controller \
        -n ingress-nginx \
        -o jsonpath='{.spec.ports[?(@.port==80)].nodePort}')

        echo ""
        echo "LoadBalancer pending"
        echo ""
        echo "Expose this port:"
        echo "${NODE_PORT}"

    fi


else

    NODE_PORT=$(kubectl get svc ingress-nginx-controller \
    -n ingress-nginx \
    -o jsonpath='{.spec.ports[?(@.port==80)].nodePort}')


    echo ""
    echo "NodePort detected"
    echo ""
    echo "Expose this port in Killercoda:"
    echo ""
    echo "  Traffic / Ports"
    echo "  TCP ${NODE_PORT}"
    echo ""


fi



echo ""
echo "===================================="
echo " Kubernetes Ephemeral Environment"
echo "===================================="
echo ""
echo "Namespace:"
echo "  ${NAMESPACE}"
echo ""
echo "Application:"
echo "  RUNNING"
echo ""
echo "Ingress:"
echo "  READY"
echo ""
echo "===================================="


echo ""
echo "Bootstrap completed successfully"
