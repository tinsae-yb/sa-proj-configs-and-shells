#!/bin/bash

# Define variables
PROJECT_ID="project-sa-386904"
CLUSTER_NAME="test-cluster"
ZONE="us-west1"


# Create GKE cluster
gcloud container clusters create $CLUSTER_NAME --project=$PROJECT_ID --zone=$ZONE --num-nodes=1 --disk-size=30GB 

# Configure kubectl to use the newly created cluster
gcloud container clusters get-credentials $CLUSTER_NAME --project=$PROJECT_ID --zone=$ZONE 

# Grant cluster-admin permissions to the current user

kubectl create clusterrolebinding cluster-admin-binding \
    --clusterrole=cluster-admin \
    --user=$(gcloud config get-value core/account)

