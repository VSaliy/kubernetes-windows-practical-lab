# kubelet Failure

## Symptoms

- node stops updating state
- kubelet service stops or flaps
- API communication errors appear

## Likely causes

- bad kubelet flags or config
- certificate, DNS, or API endpoint issues
- runtime endpoint or CNI dependency missing

## Commands to inspect

- `systemctl status kubelet`
- `journalctl -u kubelet --since -30m`
- `Get-Service kubelet`
- `Get-Content C:\var\log\kubelet\kubelet.log -Tail 200`

## Root-cause analysis steps

1. Determine whether kubelet fails to start, fails to register, or registers with degraded health.
2. Compare config with a healthy node of the same OS.
3. Check runtime and API endpoint dependencies next.

## Repair steps

1. Restore a known-good kubelet config.
2. Repair certificates or API endpoint settings.
3. Restart kubelet only after fixing its dependencies.

## Prevention

- version kubelet config in source control
- alert on repeated restarts
- validate kubelet/runtime/CNI versions together
