Function Get-CCMClientAdvertisement {
    [cmdletbinding()]

    param(
        [string[]]$ComputerName
    )

    Begin {
        $cimParam = @{            
            ClassName = 'CCM_SoftwareDistribution'
            NameSpace = 'root\ccm\policy\machine\ActualConfig'            
        }
    }

    Process {
        Get-CimInstance @cimParam -ComputerName $ComputerName
    }
}