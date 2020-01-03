#!/bin/bash

source ./vars.sh

# Create Note
curl "https://containeranalysis.googleapis.com/v1/projects/${GOOGLE_CLOUD_PROJECT}/notes/?noteId=${NOTE_ID}" \
  --request "POST" \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer $(gcloud auth print-access-token)" \
  --header "X-Goog-User-Project: ${GOOGLE_CLOUD_PROJECT}" \
  --data-binary @- <<EOF
    {
      "name": "projects/${GOOGLE_CLOUD_PROJECT}/notes/${NOTE_ID}",
      "attestation": {
        "hint": {
          "human_readable_name": "Application Tested Note"
        }
      }
    }
EOF

echo "Verifying notes..."
sleep 2

# Verify Note
curl "https://containeranalysis.googleapis.com/v1/projects/${GOOGLE_CLOUD_PROJECT}/notes/${NOTE_ID}"  \
  --header "Authorization: Bearer $(gcloud auth print-access-token)"



# Create Attestor
gcloud container binauthz attestors create $ATTESTOR_ID \
  --project "${GOOGLE_CLOUD_PROJECT}" \
  --attestation-authority-note-project "${GOOGLE_CLOUD_PROJECT}" \
  --attestation-authority-note "${NOTE_ID}" \
  --description "Application Tested Attestor"

echo "Verifying attestors..."
sleep 2

# Validate Attestors
gcloud container binauthz attestors list



# Set IAM Permissions for Note
curl "https://containeranalysis.googleapis.com/v1beta1/projects/${GOOGLE_CLOUD_PROJECT}/notes/${NOTE_ID}:setIamPolicy" \
  --request POST \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer $(gcloud auth print-access-token)" \
  --header "X-Goog-User-Project: ${GOOGLE_CLOUD_PROJECT}" \
  --data-binary @- <<EOF
    {
      "resource": "projects/${GOOGLE_CLOUD_PROJECT}/notes/",
      "policy": {
        "bindings": [{
          "role": "roles/containeranalysis.notes.occurrences.viewer",
          "members": [
            "serviceAccount:service-${PROJECT_NUMBER}@gcp-sa-binaryauthorization.iam.gserviceaccount.com"
          ]
        }]
      }
    }
EOF
