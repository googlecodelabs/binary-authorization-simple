#!/bin/bash

# Delete all deployments
kubectl delete deployment --all

# Delete all events
kubectl delete event --all

# Deploy the signed container with yaml
kubectl apply -f ./files/02-signed-deployment.yaml
