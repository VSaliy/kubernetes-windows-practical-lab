# Service Routing Failure

## Symptoms

- pods can reach each other directly but not through a Service
- ClusterIP works from one OS but not the other
- NodePort or internal load balancing behaves inconsistently

## Likely causes

- kube-proxy rules missing
- CNI and service-routing mode mismatch
- EndpointSlices empty due to readiness or selectors

## Commands to inspect

- `kubectl get svc,endpoints,endpointslices -A`
- `kubectl logs -n kube-system -l k8s-app=kube-proxy`
- `iptables-save`
- `Get-HnsLoadBalancer`

## Root-cause analysis steps

1. Prove whether the issue is DNS, Service routing, or backend registration.
2. Inspect EndpointSlices first.
3. Compare kube-proxy or dataplane state on healthy versus broken nodes.

## Repair steps

1. Fix selectors or readiness first.
2. Repair kube-proxy or dataplane programming.
3. Reconcile the service mode with documented Windows support.

## Prevention

- keep simple smoke-test services deployed
- track the chosen service-routing mode
- revalidate Services after every network change
