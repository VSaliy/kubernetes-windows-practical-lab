[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [Parameter(Mandatory = $false)]
    [string]$SwitchName = 'K8sLabExternal',

    [Parameter(Mandatory = $false)]
    [ValidateSet('External', 'Internal', 'Private')]
    [string]$SwitchType = 'External',

    [Parameter(Mandatory = $false)]
    [string]$NetAdapterName
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Customize the switch name and uplink adapter for your environment.
# The script is safe by default: it will not remove or overwrite an existing switch.

if (-not (Get-Module -ListAvailable -Name Hyper-V)) {
    throw 'Hyper-V PowerShell tools are required.'
}

$existingSwitch = Get-VMSwitch -Name $SwitchName -ErrorAction SilentlyContinue
if ($null -ne $existingSwitch) {
    Write-Host "Switch '$SwitchName' already exists. No changes made." -ForegroundColor Green
    $existingSwitch | Format-List Name, SwitchType, NetAdapterInterfaceDescription
    return
}

if ($SwitchType -eq 'External' -and [string]::IsNullOrWhiteSpace($NetAdapterName)) {
    Write-Host 'Available network adapters:' -ForegroundColor Cyan
    Get-NetAdapter | Sort-Object Name | Format-Table Name, Status, InterfaceDescription -AutoSize
    throw 'Specify -NetAdapterName before creating an external switch.'
}

if ($PSCmdlet.ShouldProcess($SwitchName, 'Create Hyper-V switch')) {
    switch ($SwitchType) {
        'External' { New-VMSwitch -Name $SwitchName -NetAdapterName $NetAdapterName -AllowManagementOS $true | Out-Null }
        'Internal' { New-VMSwitch -Name $SwitchName -SwitchType Internal | Out-Null }
        'Private'  { New-VMSwitch -Name $SwitchName -SwitchType Private | Out-Null }
    }

    Write-Host "Created switch '$SwitchName'. Review IP addressing and NAT manually before attaching lab VMs." -ForegroundColor Yellow
    Get-VMSwitch -Name $SwitchName | Format-List Name, SwitchType, NetAdapterInterfaceDescription
}
