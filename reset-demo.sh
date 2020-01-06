#!/bin/bash

source ./vars.sh

kubectl delete deployment --all
kubectl delete event --all

gcloud container images delete $CONTAINER_PATH --force-delete-tags

gcloud container binauthz attestors delete $ATTESTOR_ID

curl -vvv -X DELETE  \
    -H "Authorization: Bearer $(gcloud auth print-access-token)" \
    "https://containeranalysis.googleapis.com/v1/projects/${GOOGLE_CLOUD_PROJECT}/notes/${NOTE_ID}"

gcloud container binauthz policy import files/allow_all_policy.yaml

# Move template files into dir
cp ./files/templates/02-signed-deployment.yaml ./files/02-signed-deployment.yaml

# Update environment variables
sed -i "s/{CONTAINER_NAME}/$CONTAINER_NAME/g" "./files/02-signed-deployment.yaml"
sed -i "s~{CONTAINER_PATH}~$CONTAINER_PATH~g" "./files/02-signed-deployment.yaml"