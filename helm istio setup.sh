#!/bin/bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update


#   1. Create a namespace for the istio-system components:

kubectl create namespace istio-system

#   2. Install the istio-base chart which contains cluster-wide resources used by the Istio control plane:

helm install istio-base istio/base -n istio-system

#   3. Validate the CRD installation with the helm ls command

helm ls -n istio-system

#   4. Install the Istio discovery chart which deploys the istiod service

helm install istiod istio/istiod -n istio-system --wait

#   5.Verify the Istio discovery chart installation:


helm ls -n istio-system

#   6. Get the status of the installed helm chart to ensure it is deployed:

helm status istiod -n istio-system


#   7. Check istiod service is successfully installed and its pods are running:

kubectl get deployments -n istio-system --output wide

#   8. Install the Istio ingress gateway chart which contains the ingress gateway components:
kubectl create namespace istio-ingress
helm install istio-ingress istio/gateway -n istio-ingress --wait
