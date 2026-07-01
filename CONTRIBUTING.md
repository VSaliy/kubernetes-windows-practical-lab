# Contributing

Thanks for contributing to the Kubernetes Windows practical lab.

## Contribution principles

- Keep the content architecture-first.
- Prefer `containerd` and `kubeadm` over hidden automation.
- Explain Linux and Windows differences whenever they matter.
- Keep examples safe by default; destructive steps must always be explicit.
- Add production notes and troubleshooting guidance with new modules.

## Pull request expectations

1. Keep changes focused on one topic or module family.
2. Update related docs, manifests, and diagrams together when the architecture changes.
3. Run `make check` before opening a pull request.
4. Avoid “magic” steps that hide networking, bootstrap, or runtime details.
5. If you add a Windows-specific example, include Linux comparison notes where relevant.

## Writing guidance

Write for an experienced engineer who wants practical understanding of Kubernetes internals, not a marketing overview. Prefer precise operational language and explain trade-offs clearly.
