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
