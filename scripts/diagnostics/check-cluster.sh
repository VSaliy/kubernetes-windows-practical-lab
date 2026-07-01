#!/usr/bin/env bash
set -euo pipefail

# Customize KUBECONFIG if you are not using the default location.
if ! command -v kubectl >/dev/null 2>&1; then
  echo "kubectl is required but not found in PATH." >&2
  exit 1
fi

echo '== Cluster Info =='
kubectl cluster-info

echo
echo '== Nodes =='
kubectl get nodes -o wide

echo
echo '== kube-system Pods =='
kubectl get pods -n kube-system -o wide

echo
echo '== Recent Warning Events =='
kubectl get events -A --field-selector type=Warning --sort-by=.lastTimestamp | tail -n 20 || true

echo
echo 'Review node readiness, kube-system health, and repeated warnings before making changes.'
