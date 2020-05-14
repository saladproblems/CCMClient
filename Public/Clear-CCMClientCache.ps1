function Clear-CCMClientCache {
    [cmdletbinding(SupportsShouldProcess)]
    param (
        [Parameter(ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'ComputerName',
            Position = 0,
            Mandatory = $true)]
        [string[]]$ComputerName,

        [Parameter(ParameterSetName = 'ComputerName')]
        [PSCredential]$Credential
    )

    Begin {
        $invokeParam = @{
            ScriptBlock = {
                $CMObject = new-object -com "UIResource.UIResourceMgr"
                $cacheInfo = $CMObject.GetCacheInfo()
                $objects = $cacheinfo.GetCacheElements()
                Write-Verbose ( "Removing {0:N2}gb of CCM Cache Files" -f (($objects | Measure-Object -Property contentsize -Sum).sum/1mb) )
                $objects | ForEach-Object {
                    $cacheInfo.DeleteCacheElement($_.CacheElementId)
                }
            }
        }

        $computerList = [System.Collections.Generic.List[String]]::new()

        if ($Credential) {
            $invokeParam['Credential'] = $Credential
        }
    }

    Process {
        $computerList.AddRange([string[]]$ComputerName)
    }

    End {
        Invoke-Command @invokeParam -ComputerName $computerList
    }
}
