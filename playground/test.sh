#!/bin/sh
istioctl install --set profile=demo -y

kubectl label namespace default istio-injection=enabled

kubectl apply -f https://raw.githubusercontent.com/tinsae-yb/user-app-sample/main/user-deploy.yml
kubectl apply -f https://raw.githubusercontent.com/tinsae-yb/user-app-sample/main/user-gateway.yml

kubectl apply -f https://raw.githubusercontent.com/tinsae-yb/shop-app-sampl/main/shop-deploy.yml
kubectl apply -f https://raw.githubusercontent.com/tinsae-yb/shop-app-sampl/main/shop-gateway.yml

istioctl analyze

echo "$INGRESS_HOST"
kubectl get svc  -n istio-system