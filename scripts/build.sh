#!/bin/bash

set -e


IMAGE_NAME="edc-demo-web"

IMAGE_TAG="latest"


echo "Building Docker image..."



docker build \
    -t ${IMAGE_NAME}:${IMAGE_TAG} \
    apps/demo-web



echo ""
echo "Image created:"
echo "${IMAGE_NAME}:${IMAGE_TAG}"