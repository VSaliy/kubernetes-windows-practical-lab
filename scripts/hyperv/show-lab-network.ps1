[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (-not (Get-Module -ListAvailable -Name Hyper-V)) {
    throw 'Hyper-V PowerShell tools are required.'
}

Write-Host '=== Hyper-V Switches ===' -ForegroundColor Cyan
Get-VMSwitch | Sort-Object Name | Format-Table Name, SwitchType, NetAdapterInterfaceDescription -AutoSize

Write-Host "`n=== Host Adapters ===" -ForegroundColor Cyan
Get-NetAdapter | Sort-Object Name | Format-Table Name, Status, LinkSpeed, MacAddress -AutoSize

Write-Host "`n=== IP Configuration ===" -ForegroundColor Cyan
Get-NetIPConfiguration | Sort-Object InterfaceAlias | Format-Table InterfaceAlias, IPv4Address, IPv4DefaultGateway, DNSServer -AutoSize

Write-Host "`n=== NAT Configuration ===" -ForegroundColor Cyan
Get-NetNat -ErrorAction SilentlyContinue | Format-Table Name, InternalIPInterfaceAddressPrefix -AutoSize

Write-Host "`nReview the output and confirm that switches, subnets, gateways, and DNS settings match the documented lab architecture." -ForegroundColor Yellow
