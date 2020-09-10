function Get-CCMClientCacheConfig {
    [cmdletbinding(DefaultParameterSetName = 'none')]
    param (
        [Parameter(ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'ComputerName',
            Position = 0,
            Mandatory = $true)]
        [alias('Name')]
        [string[]]$ComputerName,

        [Parameter(ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'CimSession',
            Position = 0,
            Mandatory = $true)]
        [Microsoft.Management.Infrastructure.CimSession[]]$CimSession,

        [parameter(ParameterSetName = 'ComputerName')]
        [pscredential]$Credential
    )

    begin {
        $cimParam = @{
            NameSpace = 'root\ccm\SoftMgmtAgent'
            ClassName = 'CacheConfig'
        }
    }

    process {
        Switch ($PSCmdlet.ParameterSetName) {
            'ComputerName' {
                $cimParam['ComputerName'] = $ComputerName
            }
            'CimSession' {
                $cimParam['CimSession'] = $CimSession
            }
        }
        if ($Credential) {
            $cimParam['Credential'] = $Credential
        }

        Get-CimInstance @cimParam
    }
}