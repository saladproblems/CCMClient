function Get-CCMClientBoundaryGroupCache {
    <#
    .SYNOPSIS
        Boundary group caching was introduced with the first version of System Center Configuration Manager (ConfigMgr) Current Branch (CB): version 1511.
        As the term implies, clients cache the name of their current boundary groups
    .DESCRIPTION
        Similar to management point assignment, client’s refresh their current boundary group at three “times”:

        Every 25 hours
        At client agent startup
        When a network change is detected
    .EXAMPLE
        PS C:\> Get-CCMClientBoundaryGroupCache Computer1, Computer2
        Returns boundary cache info from two computers
    .NOTES
        https://home.configmgrftw.com/boundary-group-caching-and-missing-boundaries-in-configmgr/
    #>
    [cmdletbinding()]
    param(
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
            NameSpace = 'root/ccm/LocationServices'
            ClassName = 'BoundaryGroupCache'
        }
    }

    process {
        $sessionParam = @{
            ComputerName = $ComputerName
        }
        if ($Credential) {
            $sessionParam['Credential'] = $Credential
        }
        New-CCMClientCimSession @sessionParam |
            Get-CimInstance @cimParam
    }
}