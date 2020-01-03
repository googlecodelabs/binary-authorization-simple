#!/bin/bash

# Update policy to deny without attestation
gcloud container binauthz policy import files/updated_policy.yaml
