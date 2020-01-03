#!/bin/bash

source ./vars.sh

# Create new keyring
gcloud kms keyrings create "${KEYRING}" \
  --project "${GOOGLE_CLOUD_PROJECT}" \
  --location "${KEY_LOCATION}"

# Create new key pair for the attestor
gcloud kms keys create "${KEY_NAME}" \
  --project "${GOOGLE_CLOUD_PROJECT}" \
  --location "${KEY_LOCATION}" \
  --keyring "${KEYRING}" \
  --purpose asymmetric-signing \
  --default-algorithm "ec-sign-p256-sha256"

# Add public key to the attestory
gcloud beta container binauthz attestors public-keys add \
  --project "${GOOGLE_CLOUD_PROJECT}" \
  --attestor "${ATTESTOR_ID}"  \
  --keyversion "${KEY_VERSION}" \
  --keyversion-key "${KEY_NAME}" \
  --keyversion-keyring "${KEYRING}" \
  --keyversion-location "${KEY_LOCATION}" \
  --keyversion-project "${GOOGLE_CLOUD_PROJECT}"

echo "Verifying key for attestor..."
sleep 2

# Verify key was added
gcloud container binauthz attestors list
