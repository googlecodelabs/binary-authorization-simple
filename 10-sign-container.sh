#!/bin/bash
#
# Copyright 2020 Google LLC
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     https://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License. 

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