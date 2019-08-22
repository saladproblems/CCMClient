function Get-CCMClientSoftwareUpdate {
    [cmdletbinding()]
    param (

        [Parameter(ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'ComputerName',
            Position = 0,
            Mandatory = $true)]
        [alias('Name')]
        [string[]]$ComputerName
    )

    begin {
        $cimParam = @{
            NameSpace = 'root/ccm/ClientSDK'
            ClassName = 'CCM_SoftwareUpdate'
        }
    }

    process {
        New-CCMClientCimSession -ComputerName $ComputerName | 
            Get-CimInstance @cimParam
    }
    end {}
}