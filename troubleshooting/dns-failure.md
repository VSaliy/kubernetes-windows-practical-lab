# DNS Failure

## Symptoms

- pods cannot resolve service names
- applications time out on cluster hostnames
- lookup issues appear only from one node pool

## Likely causes

- CoreDNS unhealthy
- node-level DNS settings wrong
- CNI or service routing is broken

## Commands to inspect

- `kubectl get pods -n kube-system -l k8s-app=kube-dns`
- `kubectl logs -n kube-system deployment/coredns`
- `nslookup kubernetes.default.svc.cluster.local`
- `Resolve-DnsName kubernetes.default.svc.cluster.local`

## Root-cause analysis steps

1. Test DNS from Linux and Windows diagnostics pods.
2. Separate DNS failures from generic service-routing failures.
3. Confirm the node can reach the cluster DNS service IP.

## Repair steps

1. Restore CoreDNS scheduling and service reachability.
2. Correct node resolver settings.
3. Fix CNI or service routing first if DNS is only a downstream symptom.

## Prevention

- include DNS checks in every validation path
- avoid undocumented host DNS overrides
- document the cluster DNS service IP
