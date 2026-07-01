# ImagePullBackOff

## Symptoms

- pods remain pending with pull failures
- events mention access denied, manifest missing, or platform mismatch
- Windows pull failures happen on specific nodes

## Likely causes

- wrong registry path or tag
- wrong image architecture or Windows build
- registry egress or proxy issues

## Commands to inspect

- `kubectl describe pod <pod-name>`
- `kubectl get events --sort-by=.lastTimestamp`
- `crictl pull <image>`
- `Test-NetConnection <registry-host> -Port 443`

## Root-cause analysis steps

1. Read the exact pull event before changing anything.
2. Validate OS, architecture, and Windows compatibility.
3. Confirm registry access from the affected node.

## Repair steps

1. Correct the image reference, secret, or node selector.
2. Rebuild with the correct OS/version target if necessary.
3. Warm images only after the root cause is fixed.

## Prevention

- maintain an approved image catalog
- mirror critical images to a controlled registry
- validate Windows image tags against host patch level
