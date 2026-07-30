#!/bin/bash


source scripts/lib/common.sh


ENVIRONMENT=$1



if [ -z "$ENVIRONMENT" ]

then

echo "Usage:"
echo "./destroy.sh demo-123"

exit 1

fi



banner "Destroying ${ENVIRONMENT}"



helm uninstall \
${ENVIRONMENT} \
-n ${ENVIRONMENT} \
|| true



kubectl delete namespace \
${ENVIRONMENT}



echo ""

echo "Environment removed"