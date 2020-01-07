#!/bin/bash

source ./vars.sh

gcloud container clusters delete $CLUSTER_NAME --zone $ZONE

gcloud container images delete $CONTAINER_PATH --force-delete-tags --quiet

gcloud container binauthz attestors delete $ATTESTOR_ID

curl -vvv -X DELETE \
    -H "Authorization: Bearer $(gcloud auth print-access-token)" \
    "https://containeranalysis.googleapis.com/v1/projects/${GOOGLE_CLOUD_PROJECT}/notes/${NOTE_ID}"

gcloud container binauthz policy import files/allow_all_policy.yaml