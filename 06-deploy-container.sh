#!/bin/bash

# Delete all deployments
kubectl delete deployment --all

# Delete all events
kubectl delete event --all

# Deploy the container with yaml
kubectl apply -f ./files/01-deployment.yaml
