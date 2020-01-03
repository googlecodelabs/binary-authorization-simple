#!/bin/bash

source ./vars.sh

# Create GKE cluster
gcloud beta container clusters create \
    --enable-binauthz \
    --zone $ZONE \
    $CLUSTER_NAME