#!/bin/sh

openssl genpkey -algorithm RSA -out private_key.pem 

kubectl delete secrets  jwt-private-key 
kubectl create secret generic jwt-private-key --from-file=private_key.pem

openssl rsa -pubout -in private_key.pem -out public_key.pem

kubectl delete configMaps jwt-public-key
kubectl create configmap jwt-public-key --from-file public_key.pem 