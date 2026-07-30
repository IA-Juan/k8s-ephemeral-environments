#!/bin/bash


source scripts/lib/common.sh


ENVIRONMENT=$1



if [ -z "$ENVIRONMENT" ]

then

echo "Usage:"
echo "./deploy.sh demo-123"

exit 1

fi



banner "Deploying ${ENVIRONMENT}"



NAMESPACE=${ENVIRONMENT}



kubectl create namespace ${NAMESPACE} \
--dry-run=client \
-o yaml | kubectl apply -f -



helm dependency update \
charts/edc-environment



helm upgrade --install ${ENVIRONMENT} \
charts/edc-environment \
--namespace ${NAMESPACE} \
-f environments/${ENVIRONMENT}.yaml



echo ""

echo "Waiting for application..."



kubectl rollout status deployment \
${ENVIRONMENT}-web \
-n ${NAMESPACE}



echo ""

echo "Environment deployed:"
echo ${ENVIRONMENT}