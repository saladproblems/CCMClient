function Get-CCMClientComplianceSettings {
    [cmdletbinding(DefaultParameterSetName = 'ComputerName')]

    param (
        [Parameter(ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'ComputerName',
            Position = 0)]
        [string]$ComputerName = $env:COMPUTERNAME,

        [Parameter(ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $false,
            ParameterSetName = 'CimSession',
            Mandatory = $true)]
        [Microsoft.Management.Infrastructure.CimSession[]]$CimSession
    )

    Begin {
        $cimParam = @{
            NameSpace = 'root\ccm\dcm'
            ClassName = 'SMS_DesiredConfiguration'
        }
    }

    Process {
        Switch ($PSCmdlet.ParameterSetName) {
            'ComputerName' {
                $cimParam['ComputerName'] = $ComputerName
            }

            'CimSession' {
                $cimParam['CimSession'] = $CimSession
            }
        }
        Get-CimInstance @cimParam
    }
}