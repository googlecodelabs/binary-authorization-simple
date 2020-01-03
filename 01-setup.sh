#!/bin/bash

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