#!/bin/bash


source scripts/lib/common.sh


banner "Building application image"



IMAGE_NAME="edc-demo-web"

IMAGE_TAG="latest"



docker build \
-t ${IMAGE_NAME}:${IMAGE_TAG} \
apps/demo-web



echo ""

echo "Image created:"
echo "${IMAGE_NAME}:${IMAGE_TAG}"