# etcd Recovery

## Symptoms

- API server unavailable or inconsistent
- control-plane services seem healthy but state is stale
- recent control-plane changes preceded the outage

## Likely causes

- etcd corruption or disk loss
- untested snapshot or restore procedures
- quorum or storage latency issues

## Commands to inspect

- `kubectl get --raw=/readyz?verbose`
- `etcdctl endpoint health`
- `etcdctl snapshot status <snapshot.db>`
- `journalctl -u etcd --since -30m`

## Root-cause analysis steps

1. Determine whether the outage is corruption, quorum loss, or connectivity.
2. Verify the age and integrity of the latest backup.
3. Document node and data-path layout before restoring.

## Repair steps

1. Restore from a tested snapshot.
2. Rebuild lost control-plane nodes only after state recovery is understood.
3. Validate API, nodes, and workloads after the restore.

## Prevention

- automate etcd snapshots
- practice restore drills in the lab
- monitor control-plane storage closely
