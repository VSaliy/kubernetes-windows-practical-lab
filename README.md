# kubernetes-windows-practical-lab

A production-oriented hands-on lab for learning Kubernetes on Windows-first infrastructure without hiding the platform internals behind a managed service or a one-command installer.

This lab assumes a Windows 11 Pro workstation with Hyper-V, Ubuntu Server virtual machines for the Linux control plane and Linux workers, Windows Server 2022 virtual machines for Windows workers, `kubeadm` for cluster bootstrap, `containerd` as the runtime, `kubectl` for operations, Helm for packaging, and a CNI plugin that explicitly supports mixed Linux/Windows clusters.

## Lab purpose

The goal of this repository is to help an experienced engineer understand how a hybrid Kubernetes cluster actually works when Linux and Windows nodes must coexist. Instead of focusing on a simplified developer experience, the lab focuses on architecture, bootstrap mechanics, runtime behavior, networking, troubleshooting, and production trade-offs.

## First-principles approach

This repository is intentionally built around first principles:

- start with host virtualization and network design
- build the Linux control plane with `kubeadm`
- use `containerd` directly rather than Docker Desktop or hidden runtimes
- add Linux and Windows workers as distinct platform concerns
- make scheduling, CNI behavior, storage, and security explicit
- include failure exercises so operational understanding develops with the platform

The material is designed to explain *why* each step exists, not just *what* to type.

## Multi-OS Kubernetes architecture

A hybrid Kubernetes cluster can run Linux and Windows workloads together, but the control plane remains Linux-based. That is a core architectural fact of Kubernetes today:

- Linux is required for control-plane components such as `etcd`, `kube-apiserver`, `kube-controller-manager`, and `kube-scheduler`
- Windows nodes are supported as worker nodes only
- many ecosystem components still run only on Linux
- networking and storage support must be validated specifically for mixed-OS clusters
- Windows container images must align with Windows host versions more strictly than typical Linux image usage

The lab keeps those boundaries visible throughout the modules so that the reader understands both capability and limitation.

## Target audience

This lab is aimed at:

- experienced backend engineers and software architects
- platform engineers moving from Linux-only Kubernetes to hybrid environments
- Windows infrastructure engineers learning Kubernetes internals
- engineers who want to understand rather than abstract away bootstrap, runtime, and networking behavior

## Prerequisites

- Windows 11 Pro or Enterprise with Hyper-V enabled
- enough hardware for multiple VMs (recommended: 32 GB RAM, fast SSD, 8+ logical cores)
- Ubuntu Server images for control-plane and Linux worker nodes
- Windows Server 2022 images for Windows worker nodes
- administrator rights on the Windows host and guest VMs
- familiarity with PowerShell, Linux shell, YAML, basic IP networking, and virtualization
- basic Kubernetes concepts such as Pods, Deployments, Services, kubelet, and CNI

## Expected final architecture

By the end of the lab, the target environment should resemble:

- a Windows 11 Pro host running Hyper-V
- one or more Ubuntu control-plane nodes bootstrapped with `kubeadm`
- at least one Ubuntu Linux worker node
- at least one Windows Server 2022 worker node
- `containerd` on Linux and Windows nodes
- a CNI plugin supporting mixed Linux/Windows networking
- Linux and Windows sample workloads scheduled using explicit OS selectors
- basic storage, observability, security, and failure-handling patterns
- a final hybrid enterprise application spanning Linux and Windows components

See `/diagrams/cluster-architecture.mmd` and `/docs/00-architecture.md` for the architecture baseline.

## Module roadmap

1. [Architecture baseline](docs/00-architecture.md)
2. [Hyper-V networking](docs/01-hyper-v-networking.md)
3. [Linux control plane with kubeadm](docs/02-linux-control-plane-kubeadm.md)
4. [Linux worker node](docs/03-linux-worker-node.md)
5. [Windows worker node](docs/04-windows-worker-node.md)
6. [CNI networking](docs/05-cni-networking.md)
7. [Linux workloads](docs/06-linux-workloads.md)
8. [Windows workloads](docs/07-windows-workloads.md)
9. [Scheduling](docs/08-scheduling.md)
10. [Networking deep dive](docs/09-networking-deep-dive.md)
11. [Storage](docs/10-storage.md)
12. [Observability](docs/11-observability.md)
13. [Failure scenarios](docs/12-failure-scenarios.md)
14. [Rolling updates](docs/13-rolling-updates.md)
15. [Security](docs/14-security.md)
16. [Windows container images](docs/15-windows-container-images.md)
17. [Active Directory and gMSA](docs/16-active-directory-gmsa.md)
18. [CI/CD](docs/17-cicd.md)
19. [Production architecture](docs/18-production-architecture.md)
20. [Final project](docs/19-final-project.md)

## Repository layout

- `/docs` — architecture-first learning modules and references
- `/scripts` — safe-by-default Hyper-V, node, and diagnostic helpers
- `/manifests` — starter Kubernetes resources grouped by concern
- `/diagrams` — Mermaid diagrams for architecture and lifecycle visuals
- `/troubleshooting` — issue-focused repair guides and analysis steps
- `/final-project` — hybrid enterprise app placeholders and deployment structure
- `/.github/workflows` — offline validation that does not require a real cluster

## Important warning

This repository is a learning lab, not a copy-paste production installer. It intentionally avoids fake “one command installs everything” magic and does not try to hide Kubernetes internals. You should adapt versions, hostnames, IP ranges, security baselines, secrets handling, backup strategy, and operational controls before using any pattern from this repository in production.
