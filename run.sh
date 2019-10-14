#!/bin/sh

# Setup kubectl
aws eks --region $AWS_REGION update-kubeconfig --name $EKS_CLUSTER_NAME

# Run command 
# Example - kubectl apply -f config.yaml
eval $@