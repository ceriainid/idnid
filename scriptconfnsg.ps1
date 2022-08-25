$nsgnames = @('nsgPbl')
$getownip = (Invoke-WebRequest -uri "https://ipinfo.io/ip").Content
$myownip = @('103.47.133.143')

function UpdateSSH {
    Process {
		
		$rulename = "allow SSH"
		$ruledesc = "allow SSH to connect to the server"
		$ruleport = 22
        $nsg = Get-AzNetworkSecurityGroup -Name $_
        $ruleexists = (Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $nsg).Name.Contains($rulename);

        if($ruleexists)
        {
            # Update the existing rule with the new IP address
			Write-Output    "Rule exist, update is skipped" 
            <#
			Set-AzNetworkSecurityRuleConfig `
                -Name $rulename `
                -Description $ruledesc `
                -Access Allow `
                -Protocol TCP `
                -Direction Inbound `
                -Priority 110 `
                -SourceAddressPrefix * `
                -SourcePortRange * `
                -DestinationAddressPrefix * `
                -DestinationPortRange $ruleport `
                -NetworkSecurityGroup $nsg
			#>
        }
        else
        {
            # Create a new rule
            $nsg | Add-AzNetworkSecurityRuleConfig `
                -Name $rulename `
                -Description $ruledesc `
                -Access Allow `
                -Protocol TCP `
                -Direction Inbound `
                -Priority 110 `
                -SourceAddressPrefix * `
                -SourcePortRange * `
                -DestinationAddressPrefix * `
                -DestinationPortRange $ruleport
        }

        # Save changes to the NSG
        $nsg | Set-AzNetworkSecurityGroup
    }
}

$nsgnames | UpdateSSH | Out-Null

function UpdateHTTP {
    Process {
	
		$rulename = "allow HTTP"
		$ruledesc = "allow HTTP to connect to the server"
		$ruleport = 80
        $nsg = Get-AzNetworkSecurityGroup -Name $_
        $ruleexists = (Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $nsg).Name.Contains($rulename);

        if($ruleexists)
        {
            # Update the existing rule with the new IP address
			Write-Output    "Rule exist, update is skipped" 
            <#
			Set-AzNetworkSecurityRuleConfig `
                -Name $rulename `
                -Description $ruledesc `
                -Access Allow `
                -Protocol TCP `
                -Direction Inbound `
                -Priority 300 `
                -SourceAddressPrefix * `
                -SourcePortRange * `
                -DestinationAddressPrefix * `
                -DestinationPortRange $ruleport `
                -NetworkSecurityGroup $nsg
			#>
        }
        else
        {
            # Create a new rule
            $nsg | Add-AzNetworkSecurityRuleConfig `
                -Name $rulename `
                -Description $ruledesc `
                -Access Allow `
                -Protocol TCP `
                -Direction Inbound `
                -Priority 300 `
                -SourceAddressPrefix * `
                -SourcePortRange * `
                -DestinationAddressPrefix * `
                -DestinationPortRange $ruleport
        }

        # Save changes to the NSG
        $nsg | Set-AzNetworkSecurityGroup
    }
}

$nsgnames | UpdateHTTP | Out-Null

Write-Output "NSG Has been added"