Function Install-CCMClientSoftwareUpdate {
    [cmdletbinding()]
    [alias('Install-CCMClientSoftwareUpdates')]
    param (
        [Parameter(ValueFromPipeline = $true,
            #ValueFromPipelineByPropertyName = $true,
            #ParameterSetName = 'ComputerName',
            Position = 0,
            Mandatory = $true)]
        [alias('Update')]
        [ValidateCimClass('CCM_SoftwareUpdate')]
        [ciminstance[]]$InputObject
    )

    begin { }

    process {
        foreach ($a_ComputerName in $ComputerName) {
            $cimSessionParam = @{
                ComputerName = $a_ComputerName
            }
            if ($Credential) {
                $cimSessionParam['Credential'] = $Credential
            }

            $updateHash = $Update | Group-Object -AsHashTable -Property PSComputerName

            $cimParam = @{
                CimSession = New-CCMClientCimSession @cimSessionParam
                NameSpace  = 'root/ccm/clientsdk'
            }

            $updateHash.GetEnumerator() | ForEach-Object {
                [ciminstance[]]$updateHash[$PSItem.Key]

                #Invoke-CimMethod @cimParam -ClassName CCM_SoftwareUpdatesManager -MethodName InstallUpdates -Arguments @{ CCMUpdates = [ciminstance[]]$updateHash[$PSItem.Key] }

            }

            $updates = Get-CimInstance @cimParam -ClassName CCM_SoftwareUpdate

            $updates |
                Select-Object PSComputerName, ArticleID, Name |
                    Out-String |
                        Write-Verbose -Verbose

            $null = Invoke-CimMethod @cimParam -ClassName CCM_SoftwareUpdatesManager -MethodName InstallUpdates -Arguments @{ CCMUpdates = [ciminstance[]]$updates }
            Start-Sleep -Milliseconds 100
            $updates | Get-CimInstance
        }
    }
    end {

    }
}