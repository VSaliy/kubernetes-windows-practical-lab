[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$NodeName
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (-not (Get-Command kubectl -ErrorAction SilentlyContinue)) {
    throw 'kubectl is required and must be available in PATH.'
}

if ([string]::IsNullOrWhiteSpace($NodeName)) {
    Write-Host '=== Windows nodes ===' -ForegroundColor Cyan
    kubectl get nodes -l kubernetes.io/os=windows -o wide
    Write-Host 'Re-run with -NodeName <name> for a full inspection.' -ForegroundColor Yellow
    return
}

Write-Host "=== Windows node: $NodeName ===" -ForegroundColor Cyan
kubectl get node $NodeName -o wide
Write-Host "`n=== Node Description ===" -ForegroundColor Cyan
kubectl describe node $NodeName
Write-Host "`n=== Pods On Node ===" -ForegroundColor Cyan
kubectl get pods -A -o wide --field-selector spec.nodeName=$NodeName
Write-Host "`nReview Ready condition, image pull events, kube-proxy state, and version compatibility findings." -ForegroundColor Yellow
