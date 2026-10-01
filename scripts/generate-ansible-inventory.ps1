$ErrorActionPreference = "Stop"

$ProjectRoot = Split-Path $PSScriptRoot -Parent
$TerraformDir = Join-Path $ProjectRoot "terraform"
$InventoryFile = Join-Path $ProjectRoot "ansible\inventory\hosts.ini"

Write-Host "Reading Terraform outputs..."

Push-Location $TerraformDir

try {
    $PublicIp = terraform output -raw ansible_host
    $AnsibleUser = terraform output -raw ansible_user
}
finally {
    Pop-Location
}

if ([string]::IsNullOrWhiteSpace($PublicIp)) {
    throw "Terraform did not return an EC2 public IP."
}

Write-Host "EC2 Public IP: $PublicIp"
Write-Host "Ansible User: $AnsibleUser"

$Inventory = @"
[app]
$PublicIp ansible_user=$AnsibleUser

[app:vars]
ansible_python_interpreter=/usr/bin/python3
"@

Set-Content -Path $InventoryFile -Value $Inventory

Write-Host ""
Write-Host "Ansible inventory generated:"
Write-Host $InventoryFile