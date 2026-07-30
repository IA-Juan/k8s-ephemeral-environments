#!/bin/bash


source scripts/lib/common.sh


banner "Loading image into Kubernetes"



IMAGE_NAME="edc-demo-web:latest"



echo "Loading ${IMAGE_NAME}"



if command -v kind >/dev/null 2>&1

then

    kind load docker-image ${IMAGE_NAME}

else

    echo "No local image loader detected"

    echo "Using registry/imagePull flow"

fi