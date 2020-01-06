#!/bin/bash

export CLUSTER_NAME=binauthz-cluster

# Set the default region
export ZONE=us-central1-a

# Set the container name
export CONTAINER_NAME=hello-world

# Set the GCR path you will use to host the container image
export CONTAINER_PATH=us.gcr.io/${GOOGLE_CLOUD_PROJECT}/${CONTAINER_NAME}

# Set the note id for Container Analysis API
export NOTE_ID=qa-note

# Set the attestor for the BinAuthZ API
export ATTESTOR_ID=qa-attestor

# Project Number
export PROJECT_NUMBER=$(gcloud projects describe "${GOOGLE_CLOUD_PROJECT}"  --format="value(projectNumber)")

# BinAuthZ Service Acccount Email
export BINAUTHZ_SA_EMAIL="service-${PROJECT_NUMBER}@gcp-sa-binaryauthorization.iam.gserviceaccount.com"

# KMS Details
export KEY_LOCATION=global
export KEYRING=binauthz-keys
export KEY_NAME=qa-attestor-key
export KEY_VERSION=1