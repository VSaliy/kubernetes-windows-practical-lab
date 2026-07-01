# CrashLoopBackOff

## Symptoms

- containers restart repeatedly
- readiness never stabilizes
- one OS variant crashes while the other works

## Likely causes

- bad command line or configuration
- probe timing too aggressive
- OS-specific path or dependency assumptions

## Commands to inspect

- `kubectl logs <pod-name> --previous`
- `kubectl describe pod <pod-name>`
- `kubectl exec <pod-name> -- env`
- `kubectl exec <pod-name> -- powershell -Command Get-ChildItem C:\`

## Root-cause analysis steps

1. Inspect exit codes and previous logs first.
2. Compare Linux and Windows startup assumptions.
3. Check whether probes are causing avoidable restarts.

## Repair steps

1. Fix configuration or startup commands.
2. Adjust readiness/startup timing if appropriate.
3. Rebuild the image if the runtime layout is wrong.

## Prevention

- add startup diagnostics
- document expected cold-start times
- keep config and secrets versioned
