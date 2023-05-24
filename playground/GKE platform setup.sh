#!/bin/bash

gcloud container clusters create sa-project \
  --cluster-version latest \
  --machine-type=n2-standard-4 \
  --num-nodes 4 \
  --zone us-west1 \
  --project project-sa-386904
