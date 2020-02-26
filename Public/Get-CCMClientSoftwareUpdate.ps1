function Get-CCMClientSoftwareUpdate {
    [cmdletbinding()]
    param (

        [Parameter(ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'ComputerName',
            Position = 0,
            Mandatory = $true)]
        [alias('Name')]
        [string[]]$ComputerName,

        [parameter()]
        [pscredential]$Credential
    )

    begin {
        $cimParam = @{
            NameSpace = 'root/ccm/ClientSDK'
            ClassName = 'CCM_SoftwareUpdate'
        }
    }

    process {
        $sessionParam = @{
            ComputerName = $ComputerName        
        }
        if($Credential) {
            $sessionParam['Credential'] = $Credential
        }
        New-CCMClientCimSession @sessionParam | 
            Get-CimInstance @cimParam
    }
    end {}
}