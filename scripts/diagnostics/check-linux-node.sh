#!/usr/bin/env bash
set -euo pipefail

node_name="${1:-}"

if ! command -v kubectl >/dev/null 2>&1; then
  echo "kubectl is required but not found in PATH." >&2
  exit 1
fi

if [[ -n "$node_name" ]]; then
  echo "== Linux node: $node_name =="
  kubectl get node "$node_name" -o wide
  echo
  kubectl describe node "$node_name"
  echo
  kubectl get pods -A -o wide --field-selector spec.nodeName="$node_name" || true
else
  echo '== Linux nodes =='
  kubectl get nodes -l kubernetes.io/os=linux -o wide
  echo
  echo 'Pass a node name for a full describe and pod listing.'
fi

echo
echo 'Inspect kubelet, containerd, CNI, disk pressure, and network state on the guest OS if conditions are degraded.'
