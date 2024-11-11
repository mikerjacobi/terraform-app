#!/bin/bash

# Set variables
PROJECT_ID="socket-os"
IMAGE_NAME="api"
IMAGE_TAG="latest"
GCR_URL="gcr.io"

# Build the Docker image
docker build -t $GCR_URL/$PROJECT_ID/$IMAGE_NAME:$IMAGE_TAG .

# Push the Docker image to Google Container Registry
docker push $GCR_URL/$PROJECT_ID/$IMAGE_NAME:$IMAGE_TAG

# Verify the image is pushed
gcloud container images list-tags $GCR_URL/$PROJECT_ID/$IMAGE_NAME

kubectl delete pods -l app=api
