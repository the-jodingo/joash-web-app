#!/bin/bash
# Deploy script for joash-web-app

set -euo pipefail

ENVIRONMENT=${1:-dev}

echo "🚀 Deploying joash-web-app to ${ENVIRONMENT}..."



echo "Executing blue-green deployment..."
kubectl apply -f deployments/blue-green.yaml
echo "✅ Blue-green deployment initiated"


echo "🎉 Deployment to ${ENVIRONMENT} complete!"
