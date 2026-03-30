#!/bin/bash
set -e

DEP_NAME=$1
CURRENT_VERSION=$2
NEW_VERSION=$3

case "$DEP_NAME" in
  "kubernetes/ingress-nginx")
    URL="https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-${NEW_VERSION}/deploy/static/provider/cloud/deploy.yaml"
    FILE_PATH="clusters/delta/infrastructure/ingress-nginx/deploy.yaml"
    ;;
  "rancher/local-path-provisioner")
    URL="https://raw.githubusercontent.com/rancher/local-path-provisioner/refs/tags/${NEW_VERSION}/deploy/local-path-storage.yaml"
    FILE_PATH="clusters/delta/infrastructure/local-path-storage/local-path-storage.yaml"
    ;;
  "bitnami-labs/sealed-secrets")
    URL="https://github.com/bitnami-labs/sealed-secrets/releases/download/${NEW_VERSION}/controller.yaml"
    FILE_PATH="clusters/delta/infrastructure/sealed-secrets/controller.yaml"
    ;;
  "cert-manager/cert-manager")
    URL="https://github.com/cert-manager/cert-manager/releases/download/${NEW_VERSION}/cert-manager.yaml"
    FILE_PATH="clusters/delta/infrastructure/cert-manager/cert-manager.yaml"
    ;;
  "metallb/metallb")
    URL="https://raw.githubusercontent.com/metallb/metallb/refs/tags/${NEW_VERSION}/config/manifests/metallb-native.yaml"
    FILE_PATH="clusters/delta/infrastructure/metallb-system/metallb-native.yaml"
    ;;
  *)
    echo "Unknown component: $DEP_NAME"
    exit 1
    ;;
esac

echo "Downloading $DEP_NAME version $NEW_VERSION from $URL"
curl --fail -L -o "$FILE_PATH" "$URL"