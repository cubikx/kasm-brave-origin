#!/usr/bin/env bash

IMAGE_NAME="yourrepo/kasm-brave"
TAG="latest"

docker build -t ${IMAGE_NAME}:${TAG} .
docker push ${IMAGE_NAME}:${TAG}
