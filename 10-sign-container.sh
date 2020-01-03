#!/bin/bash

source ./vars.sh

# Get digest from container we created
DIGEST=$(gcloud container images describe ${CONTAINER_PATH}:latest \
    --format='get(image_summary.digest)')

# Sign and create attestation for container
gcloud beta container binauthz attestations sign-and-create  \
    --artifact-url="${CONTAINER_PATH}@${DIGEST}" \
    --attestor="${ATTESTOR_ID}" \
    --attestor-project="${GOOGLE_CLOUD_PROJECT}" \
    --keyversion-project="${GOOGLE_CLOUD_PROJECT}" \
    --keyversion-location="${KEY_LOCATION}" \
    --keyversion-keyring="${KEYRING}" \
    --keyversion-key="${KEY_NAME}" \
    --keyversion="${KEY_VERSION}"

echo "Waiting for container to be signed..."
sleep 5

# Verify attestations
gcloud container binauthz attestations list \
   --attestor=$ATTESTOR_ID --attestor-project=${GOOGLE_CLOUD_PROJECT}

# Update deployment file with container digest
sed -i "s/{DIGEST}/$DIGEST/g" "files/02-signed-deployment.yaml"