# Node NotReady

## Symptoms

- node condition changes to `NotReady`
- pods stop scheduling or are evicted
- lease updates or heartbeats appear stale

## Likely causes

- lost VM connectivity
- kubelet, containerd, or CNI failure
- clock skew, certificate issues, or resource exhaustion

## Commands to inspect

- `kubectl get nodes -o wide`
- `kubectl describe node <node-name>`
- `journalctl -u kubelet -u containerd --since -30m`
- `Get-Service kubelet,containerd`

## Root-cause analysis steps

1. Confirm whether one node or the entire cluster is affected.
2. Check recent host, VM, IP, DNS, or firewall changes.
3. Correlate Ready condition transitions with kubelet and runtime logs.

## Repair steps

1. Restore connectivity first.
2. Repair kubelet, containerd, certificate, or CNI issues based on evidence.
3. Drain or rejoin the node only after collecting diagnostics.

## Prevention

- monitor node health continuously
- reserve CPU, memory, and disk for node services
- document known-good node network baselines
