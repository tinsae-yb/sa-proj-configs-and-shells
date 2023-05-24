#!/bin/bash

echo "installing helm"

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh


echo "adding istio repo"
helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update


echo "creating istio-system namespace"
kubectl create namespace istio-system

echo "injection enabled"
kubectl label namespace default istio-injection=enabled

echo "installing istio-base"
helm install istio-base istio/base -n istio-system

echo "installing istiod"
helm install istiod istio/istiod -n istio-system 

echo "checking helm status"
helm status istiod -n istio-system


echo "checking deployments"
kubectl get deployments -n istio-system --output wide

echo "creating istio-ingress namespace"
kubectl create namespace istio-ingress

echo "installing istio-ingress"
helm install istio-ingress istio/gateway -n istio-ingress 




echo "db installation"




echo " installing database for review service - mongodb"
helm install  review-mongodb-sharded \
  --set auth.rootPassword=password,shards=2,configsvr.replicaCount=2,shardsvr.dataNode.replicaCount=2,service.name=mongodb-review-sharded \
    oci://registry-1.docker.io/bitnamicharts/mongodb-sharded 



echo " installing database for delivery service - mongodb"

helm install mongodb-delivery-deploy oci://registry-1.docker.io/bitnamicharts/mongodb 


echo    " installing database for restaurant service - mongodb"

helm install mongodb-restaurant-deploy oci://registry-1.docker.io/bitnamicharts/mongodb 

echo " installing database for user service - mongodb"

helm install mongo-user oci://registry-1.docker.io/bitnamicharts/mongodb 


echo " installing kafka"

helm install kafka-deploy oci://registry-1.docker.io/bitnamicharts/kafka 

echo " installing mysql for order service"
helm install mysql-order-deploy oci://registry-1.docker.io/bitnamicharts/mysql 

echo " installing mysql for shopping card service"
helm install mysql-shopping-cart-deploy oci://registry-1.docker.io/bitnamicharts/mysql 





echo "installing grafana"
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.17/samples/addons/grafana.yaml

echo "installing prometheus"
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.17/samples/addons/prometheus.yaml


echo "istalling zipkin"
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.17/samples/addons/extras/zipkin.yaml

echo "installing kiali"
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.17/samples/addons/kiali.yaml


echo "virtual service for grafana,  kiali, zipkin"
kubectl apply -f ./zipkin-grafana-kiali-virtual-service.yml


echo "adding public key config"
kubectl apply -f ./public-key-configmap.yml

echo "adding private key secret"
kubectl apply -f ./private-key-secret.yml

echo "deploying secret reader role binding to default namespace"
kubectl apply -f ./secret-reader.yml

echo "deploying gateway"
kubectl apply -f ./gateway.yml



echo "user deployment"
kubectl apply -f ./user-dep.yaml

echo "review deployment"
kubectl apply -f ./review-dep.yml

echo "restaurant deployment"
kubectl apply -f ./restaurant-dep.yml

echo "order deployment"
kubectl apply -f ./order-dep.yml

echo "delivery deployment"
kubectl apply -f ./delivery-dep.yml

echo "notification dep"
kubectl apply -f ./notification-dep.yml

echo "shopping cart dep"
kubectl apply -f ./shoppingcart-deployment.yml

echo "jwks deployment"
kubectl apply -f ./jwks-dep.yml

echo "authentification deployment"
kubectl apply -f ./request-authentication.yml






