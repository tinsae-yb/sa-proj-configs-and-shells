#!/bin/bash

helm repo add openzipkin https://openzipkin.github.io/zipkin
helm install my-zipkin openzipkin/zipkin -n istio-system --wait --debug
