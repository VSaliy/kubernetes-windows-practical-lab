# containerd Failure

## Symptoms

- pods cannot start because runtime is unavailable
- kubelet reports CRI errors
- image pulls and sandbox creation fail

## Likely causes

- containerd crashed or is misconfigured
- runtime endpoint mismatch
- disk pressure or filesystem corruption

## Commands to inspect

- `systemctl status containerd`
- `journalctl -u containerd --since -30m`
- `Get-Service containerd`
- `ctr version`
- `crictl info`

## Root-cause analysis steps

1. Decide whether containerd is down, misconfigured, or only failing for one workload.
2. Inspect runtime config and disk state.
3. Correlate runtime failure with kubelet events.

## Repair steps

1. Restore a known-good runtime config.
2. Free disk or repair corrupted runtime state cautiously.
3. Restart containerd and kubelet only after addressing the cause.

## Prevention

- keep runtime config minimal
- monitor image and snapshot disk usage
- test runtime upgrades per OS
