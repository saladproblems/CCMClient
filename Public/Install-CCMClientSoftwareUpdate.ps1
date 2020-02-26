Function Install-CCMClientSoftwareUpdate {
    [cmdletbinding()]
    [alias('Install-CCMClientSoftwareUpdates')]
    param (
        [Parameter]

        [Parameter(ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'ComputerName',
            Position = 0,
            Mandatory = $true)]
        #[alias('Name')]
        [string[]]$ComputerName,

        [Parameter(ParameterSetName = 'ComputerName')]
        [PSCredential]$Credential
    )

    begin {}

    process {
        foreach ($a_ComputerName in $ComputerName){
            $cimSessionParam = @{
                ComputerName = $a_ComputerName
            }
            if ($Credential){
                $cimSessionParam['Credential'] = $Credential
            }

            $cimParam = @{
                CimSession = New-CCMClientCimSession @cimSessionParam
                NameSpace = 'root/ccm/clientsdk'
            }

            $updates = Get-CimInstance @cimParam -ClassName CCM_SoftwareUpdate

            $updates |
                Select-Object PSComputerName,ArticleID,Name |
                    Out-String |
                        Write-Verbose -Verbose

            $null = Invoke-CimMethod @cimParam -ClassName CCM_SoftwareUpdatesManager -MethodName InstallUpdates -Arguments @{ CCMUpdates = [ciminstance[]]$updates }
            Start-Sleep -Milliseconds 100
            $updates | Get-CimInstance
        }
    }
    end {}
}

<#
$update[0].CimSystemProperties.ServerName

$cimParam = @{
    CimSession = New-CCMClientCimSession -ComputerName $update[0].CimSystemProperties.ServerName
    NameSpace = 'root/ccm/clientsdk'
}

Invoke-CimMethod @cimParam -ClassName CCM_SoftwareUpdatesManager -MethodName InstallUpdates -Arguments @{ CCMUpdates = [ciminstance[]]$update[0] }
#>