# Binary Authorization Demo

## NOTE: This is not an officially supported Google product

### Scripts can be executed in sequential order, see example flow below

### Update variables in `vars.sh` for customization

### Example Flow

```
# Enable APIs and create deploy files from templates
./01-setup.sh

# Create cluster with BinAuthZ enabled
# NOTE: This command takes a while to create a cluster, better to have pre-created cluster and skip this
./02-create-cluster.sh

# Build a container and push to GCR
./03-build-container.sh

# Show successfully deployment
./04-deploy-container.sh

kubectl get pods

# Apply BinAuthZ policy to deny all
./05-deploy-deny-policy.sh

# Delete all deployments and events and re-deploy container
./06-deploy-container.sh

# Show event logs that container has failed to be deployed
./07-show-events.sh

kubectl get pods

# Create the Container Analysis API Note, BinAuthZ Attestor and grant IAM permission for BinAuthZ to use the Note
./08-create-note-attestor-iam.sh

# Create the keyring and key pair and assign public key for the Attestor
./09-create-kms-key.sh

# Sign the container and update deployment with container digest
./10-sign-container.sh

# Apply BinAuthZ policy to require attestation for our Attestor
./11-deploy-updated-policy.sh

# Deploy our signed container and see success
./12-deploy-signed-container.sh

kubectl get pods

# Deploy a non-signed container with whitelist/break-glass procedure
./13-deploy-break-glass.sh

# Deploy our container without digest and watch it fail
./14-deploy-invalid-container

# To reset the demo for another use, use this command
./reset-demo.sh

# To cleanup the project use this command
./cleanup-project.sh
```

### See Codelab for supporting documentation:
### https://codelabs.developers.google.com/codelabs/cloud-binauthz-intro/index.html
