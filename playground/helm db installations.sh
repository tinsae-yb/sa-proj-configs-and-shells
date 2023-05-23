#!/bin/bash

# Define variables
# ARCHITECTURE="replicaset"


# helm install mongo-review \
#     --set architecture=$ARCHITECTURE,auth.rootPassword=password,auth.username=user,auth.password=password,auth.database=review-db,replicaCount=3 \
#     oci://registry-1.docker.io/bitnamicharts/mongodb


helm install  review-mongodb-sharded \
  --set auth.rootPassword=password,shards=4,configsvr.replicaCount=2,shardsvr.dataNode.replicaCount=2,service.name=mongodb-review-sharded \
    oci://registry-1.docker.io/bitnamicharts/mongodb-sharded






[helm for mongodb - delivery]

helm install mongodb-delivery-deploy oci://registry-1.docker.io/bitnamicharts/mongodb


[helm for mongodb - restaurant]

helm install mongodb-restaurant-deploy oci://registry-1.docker.io/bitnamicharts/mongodb


[helm for mongodb - user]

helm install mongo-user oci://registry-1.docker.io/bitnamicharts/mongodb

[helm for kafka]

helm install kafka-deploy oci://registry-1.docker.io/bitnamicharts/kafka


[helm for mysql]

helm install mysql-order-deploy oci://registry-1.docker.io/bitnamicharts/mysql

