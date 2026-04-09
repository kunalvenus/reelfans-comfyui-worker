#!/bin/bash
# Run this ON a RunPod CPU/GPU pod to build and push the Docker image.
#
# Steps:
# 1. Create a cheap RunPod pod (any GPU, or CPU — we just need Docker + fast internet)
# 2. SSH into it: ssh root@<pod-ip> -p <port> -i ~/.ssh/id_ed25519
# 3. Run these commands:

set -e

# Clone the worker files (or just copy Dockerfile + workflow_api.json)
mkdir -p /workspace/reelfans-worker
cd /workspace/reelfans-worker

# If you uploaded the files:
# (otherwise paste the Dockerfile and workflow_api.json here)

echo "Logging into Docker Hub..."
docker login -u kunalvenus

echo "Building image (this downloads ~25GB of models, takes 15-30 min)..."
docker build -t kunalvenus/reelfans-comfyui-worker:v1 -t kunalvenus/reelfans-comfyui-worker:latest .

echo "Pushing to Docker Hub..."
docker push kunalvenus/reelfans-comfyui-worker:v1
docker push kunalvenus/reelfans-comfyui-worker:latest

echo ""
echo "Done! Now create a serverless endpoint at https://www.runpod.io/console/serverless"
echo "  Image: kunalvenus/reelfans-comfyui-worker:v1"
echo "  GPU: B200 or H200"
echo "  Min workers: 1"
