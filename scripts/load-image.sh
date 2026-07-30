#!/bin/bash

source scripts/lib/common.sh

banner "Loading image into Kubernetes"

IMAGE_NAME="edc-demo-web:latest"

echo "Loading ${IMAGE_NAME}"


if command -v kind >/dev/null 2>&1
then

    echo "Detected kind cluster"

    kind load docker-image ${IMAGE_NAME}


else

    echo "Detected containerd Kubernetes runtime"

    TMP_IMAGE="/tmp/edc-demo-web.tar"


    docker save ${IMAGE_NAME} -o ${TMP_IMAGE}


    sudo ctr -n k8s.io images import ${TMP_IMAGE}


    echo "Image imported into containerd"


fi


echo ""
echo "Verifying image availability"

sudo ctr -n k8s.io images ls | grep edc-demo-web
