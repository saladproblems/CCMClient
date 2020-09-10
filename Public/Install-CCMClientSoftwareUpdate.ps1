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

    begin {
        $updateList = [System.Collections.Generic.List[ciminstance]]::new()
    }

    process {
        $updateList.AddRange($InputObject)
    }
    end {
        $updateHash = $updateList | Group-Object { $PSItem.CimSystemProperties.ServerName } -AsHashTable -AsString
        Invoke-Command -ComputerName $updateHash.Keys.Where({$PSItem}) -ScriptBlock {
            $localUpdateHash = $using:updateHash
            $cimParam = @{
                NameSpace  = 'root/ccm/clientsdk'
                ClassName  = 'CCM_SoftwareUpdatesManager'
                MethodName = 'InstallUpdates'
                Arguments  = @{
                    CCMUpdates = [ciminstance[]]$localUpdateHash[$env:COMPUTERNAME]
                }
            }
            Invoke-CimMethod @cimParam #-ClassName CCM_SoftwareUpdatesManager -MethodName InstallUpdates -Arguments @{ CCMUpdates = [ciminstance[]]$updateHash[$PSItem.Key] }
        }
    }
}