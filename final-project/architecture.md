# Final Project Architecture

## Objectives

- prove that Linux and Windows workloads can coexist in one cluster intentionally
- keep storage, identity, observability, and scheduling decisions visible
- treat the project as an architecture and operations exercise, not just a demo deploy

## Suggested deployment order

1. create namespace and baseline policies
2. deploy Linux frontend and Java API gateway
3. add Kafka and Redis
4. add Prometheus and Grafana placeholders
5. deploy Windows ASP.NET Framework app and Windows worker
6. attach SMB-backed storage
7. add Active Directory and gMSA integration last

## Review prompts

- Which components are Linux-only and why?
- Which components are Windows-specific and why?
- How will image versioning and rollout sequencing differ across OS boundaries?
- What fails if the Windows node pool becomes unavailable?
