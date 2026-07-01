# Windows Container Version Mismatch

## Symptoms

- Windows pods fail immediately
- events mention unsupported platform or incompatibility
- the same manifest behaves differently across Windows nodes

## Likely causes

- host/image version mismatch
- inconsistent Windows patch level across nodes
- wrong OS scheduled to the node

## Commands to inspect

- `kubectl describe pod <pod-name>`
- `kubectl get nodes -l kubernetes.io/os=windows -o wide`
- `Get-ComputerInfo | Select-Object WindowsVersion, OsBuildNumber`
- `ctr images ls`

## Root-cause analysis steps

1. Map the image tag to the Windows host build.
2. Check whether all Windows nodes share a consistent patch baseline.
3. Verify `nodeSelector: kubernetes.io/os: windows` is present.

## Repair steps

1. Retag or rebuild the image for the correct Windows version.
2. Patch or reprovision inconsistent nodes.
3. Use dedicated pools if multiple Windows versions must coexist temporarily.

## Prevention

- publish compatibility guidance
- upgrade Windows nodes as coordinated pools
- gate image promotions on host-version validation
