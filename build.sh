#!/bin/bash
# Build and push the RunPod ComfyUI worker image
# Usage: ./build.sh

set -e

IMAGE="kunalvenus/reelfans-comfyui-worker"
TAG="v1"

echo "Building $IMAGE:$TAG ..."
echo "This will download ~25GB of models — expect 15-30 min on first build."
echo ""

docker build -t "$IMAGE:$TAG" -t "$IMAGE:latest" .

echo ""
echo "Pushing to Docker Hub..."
docker push "$IMAGE:$TAG"
docker push "$IMAGE:latest"

echo ""
echo "Done! Image: $IMAGE:$TAG"
echo ""
echo "Next steps:"
echo "  1. Go to https://www.runpod.io/console/serverless"
echo "  2. Create new endpoint"
echo "  3. Container image: $IMAGE:$TAG"
echo "  4. GPU: B200 (180GB) or H200 (141GB)"
echo "  5. Min workers: 1, Max workers: 2"
echo "  6. Save and note the Endpoint ID"
