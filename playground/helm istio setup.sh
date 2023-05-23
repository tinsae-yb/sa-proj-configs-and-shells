#!/bin/bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update



kubectl create namespace istio-system


helm install istio-base istio/base -n istio-system


helm ls -n istio-system


helm install istiod istio/istiod -n istio-system --wait




helm ls -n istio-system


helm status istiod -n istio-system




kubectl get deployments -n istio-system --output wide


kubectl label namespace default istio-injection=enabled

echo "creating istio-ingress namespace"
kubectl create namespace istio-ingress


echo "installing istio-ingress"
helm install istio-ingress istio/gateway -n istio-ingress --wait --debug



