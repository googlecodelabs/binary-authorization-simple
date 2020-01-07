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

# Enable GKE to create and manage your cluster
gcloud services enable container.googleapis.com

# Enable BinAuthz to manage a policy on the cluster
gcloud services enable binaryauthorization.googleapis.com

# Enable KMS to manage cryptographic signing keys
gcloud services enable cloudkms.googleapis.com


# Move template files into dir
cp ./files/templates/01-deployment.yaml ./files/01-deployment.yaml
cp ./files/templates/02-signed-deployment.yaml ./files/02-signed-deployment.yaml
cp ./files/templates/03-break-glass-deployment.yaml ./files/03-break-glass-deployment.yaml
cp ./files/templates/updated_policy.yaml ./files/updated_policy.yaml

# Update environment variables
sed -i "s/{CONTAINER_NAME}/$CONTAINER_NAME/g" "./files/01-deployment.yaml"
sed -i "s~{CONTAINER_PATH}~$CONTAINER_PATH~g" "./files/01-deployment.yaml"

sed -i "s/{CONTAINER_NAME}/$CONTAINER_NAME/g" "./files/02-signed-deployment.yaml"
sed -i "s~{CONTAINER_PATH}~$CONTAINER_PATH~g" "./files/02-signed-deployment.yaml"

sed -i "s/{CONTAINER_NAME}/$CONTAINER_NAME/g" "./files/03-break-glass-deployment.yaml"
sed -i "s~{CONTAINER_PATH}~$CONTAINER_PATH~g" "./files/03-break-glass-deployment.yaml"

sed -i "s/{GOOGLE_CLOUD_PROJECT}/$GOOGLE_CLOUD_PROJECT/g" "./files/updated_policy.yaml"
sed -i "s/{ATTESTOR_ID}/$ATTESTOR_ID/g" "./files/updated_policy.yaml"