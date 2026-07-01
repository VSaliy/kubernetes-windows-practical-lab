# CNI Broken

## Symptoms

- pods stay in `ContainerCreating` or lose connectivity
- cross-node traffic fails
- service behavior differs across Linux and Windows

## Likely causes

- unsupported mixed-OS configuration
- missing or inconsistent CNI binaries/config
- MTU, routing, or overlay mismatch

## Commands to inspect

- `kubectl get pods -n kube-system -o wide`
- `kubectl logs -n kube-system <cni-pod>`
- `ip route`
- `Get-HnsNetwork`

## Root-cause analysis steps

1. Determine whether the issue is Linux-only, Windows-only, or cluster-wide.
2. Trace one pod-to-pod and pod-to-service flow end to end.
3. Compare current plugin config with the intended design.

## Repair steps

1. Reapply the validated CNI config.
2. Correct routing or MTU mismatches.
3. Rebuild only the broken networking layer rather than the entire cluster.

## Prevention

- choose a plugin with explicit Windows support
- test plugin upgrades in a staging lab
- capture known-good route and HNS state
