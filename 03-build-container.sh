#!/bin/bash

source ./vars.sh

# Build container
docker build -t $CONTAINER_PATH ./files

# Auth for cloud shell docker to Google Container Registry
gcloud auth configure-docker --quiet

# Push to Google Container Registry
docker push $CONTAINER_PATH
