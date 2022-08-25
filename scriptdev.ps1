$newrg = "idnid"
$loc = "eastus"

Write-Output `n "================================ ENVIRONMENT CREATION ================================"

Write-Output `n "======================================================================================" 
Write-Output    "================================   Creating RG: idn   ================================" 
Write-Output    "======================================================================================" `n

$check = Get-AzResourceGroup -Name $newrg -ErrorAction SilentlyContinue

if($check -eq $null){

    New-AzResourceGroup -Name $newrg -Location $loc
	
}
else{

    Write-Host "RESOURCEGROUP already exist"
	
}

Write-Output `n "======================================================================================" 
Write-Output    "=================================   Creating  VNET   =================================" 
Write-Output    "======================================================================================" `n

$check = Get-AzVirtualNetwork -Name 'vnetidnid' -ErrorAction SilentlyContinue

if($check -eq $null){
	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $newrg `
	  -TemplateUri "https://raw.githubusercontent.com/ceriainid/idnid/master/idnid/vnet.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/ceriainid/idnid/master/idnid/vneta.json"
}

else{

    Write-Host "VIRTUALNETWORK already exist"

}

Write-Output `n "======================================================================================" 
Write-Output    "==================================   Creating NSG   ==================================" 
Write-Output    "======================================================================================" `n

$check = Get-AzNetworkSecurityGroup -Name 'nsgPbl' -ErrorAction SilentlyContinue

if($check -eq $null){

New-AzResourceGroupDeployment `
  -Name remoteTemplateDeployment `
  -ResourceGroupName $newrg `
  -TemplateUri "https://raw.githubusercontent.com/ceriainid/idnid/master/idnid/nsg.json" `
  -TemplateParameterUri "https://raw.githubusercontent.com/ceriainid/idnid/master/idnid/nsgPbl.json"
  
}

else{

    Write-Host "NSGPBL already exist"

}

Write-Output `n "======================================================================================" 
Write-Output    "===============================  Creating PubIP-UBT01A ================================" 
Write-Output    "======================================================================================" `n

$check = Get-AzPublicIpAddress -Name 'pipubt16a' -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $newrg `
	  -TemplateUri "https://raw.githubusercontent.com/ceriainid/idnid/master/idnid/pip.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/ceriainid/idnid/master/idnid/pipubt16a.json"
	  
}

else{

    Write-Host "PIPUBT01A already exist"

}

Write-Output `n "======================================================================================" 
Write-Output    "===========================  Creating VNetIntface-UBT01A  =============================" 
Write-Output    "======================================================================================" `n

$check = Get-AzNetworkInterface -Name 'vnicubt16a' -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $newrg `
	  -TemplateUri "https://raw.githubusercontent.com/ceriainid/idnid/master/idnid/vnic.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/ceriainid/idnid/master/idnid/vnicubt16a.json"
	  
}

else{

    Write-Host "VNICUBT01A already exist"

}

Write-Output `n "======================================================================================" 
Write-Output    "================================   Creating VM-UBT16A  ================================" 
Write-Output    "======================================================================================" `n

$check = Get-AzVM -Name 'vmubt16a' -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $newrg `
	  -TemplateUri "https://raw.githubusercontent.com/ceriainid/idnid/master/idnid/vmubt16.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/ceriainid/idnid/master/idnid/vmubt16a.json"
	  
}

else{

    Write-Host "VMUBT01A already exist"

}

Write-Output `n "======================================================================================" 
Write-Output    "================================   Configuration SSH  ================================" 
Write-Output    "======================================================================================" `n

$script = Invoke-WebRequest "https://raw.githubusercontent.com/ceriainid/idnid/master/idnid/scriptconfnsg.ps1"
Invoke-Expression $($script.Content)

Write-Output `n "======================================================================================" 
Write-Output    "==============================   COMMAND IS: FINISHED   ==============================" 
Write-Output    "======================================================================================" `n