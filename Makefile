SHELL := /usr/bin/env bash

.PHONY: check validate-yaml validate-manifests check-shell check-powershell

check: validate-yaml validate-manifests check-shell check-powershell

validate-yaml:
	python3 -m pip install --quiet PyYAML
	python3 <<'PYCODE'
from pathlib import Path
import yaml

for path in sorted(
    p for p in Path('.').rglob('*')
    if p.suffix in {'.yaml', '.yml'} and '.git/' not in p.as_posix()
):
    with path.open('r', encoding='utf-8') as handle:
        list(yaml.safe_load_all(handle))
    print(f'YAML OK: {path}')
PYCODE

validate-manifests:
	@command -v kubectl >/dev/null 2>&1 || { echo 'kubectl is required'; exit 1; }
	@set -euo pipefail; \
	for file in $$(find manifests final-project/manifests -type f \( -name '*.yaml' -o -name '*.yml' \) | sort); do \
	  echo "kubectl dry-run: $$file"; \
	  if kubectl apply --dry-run=client --validate=false -f "$$file" >/dev/null 2>.tmp-kubectl.err; then \
	    echo "kubectl OK: $$file"; \
	  elif grep -Eq 'connection refused|failed to download openapi|couldn.t get current server API group list|unable to recognize' .tmp-kubectl.err; then \
	    echo "kubectl skipped (offline discovery limitation): $$file"; \
	  else \
	    cat .tmp-kubectl.err; rm -f .tmp-kubectl.err; exit 1; \
	  fi; \
	done; \
	rm -f .tmp-kubectl.err

check-shell:
	bash -n scripts/diagnostics/*.sh

check-powershell:
	pwsh -NoLogo -NoProfile -Command '$$allErrors = @(); Get-ChildItem scripts -Recurse -Filter *.ps1 | ForEach-Object { $$parseErrors = $$null; [System.Management.Automation.Language.Parser]::ParseFile($$_.FullName, [ref]$$null, [ref]$$parseErrors) | Out-Null; if ($$parseErrors) { $$allErrors += $$parseErrors } }; if ($$allErrors.Count -gt 0) { $$allErrors | ForEach-Object { Write-Error $$_.Message }; exit 1 }'
