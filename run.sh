#!/bin/sh

# Setup kubectl
aws eks --region $AWS_REGION update-kubeconfig --name $EKS_CLUSTER_NAME

# Configure kubectl to set namespace
kubectl config set-context --current --namespace=$NAMESPACE

# Apply the configuration file that was passed in as paramter
kubectl apply -f $@

# Restart pushowl-backend deployments to reflect the new environment
deployments_to_reload=$(kubectl get deployment | grep -E '^pushowl-backend' | awk '{print "deployment/"$1}')
kubectl rollout restart $deployments_to_reload
