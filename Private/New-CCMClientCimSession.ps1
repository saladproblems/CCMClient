function New-CCMClientCimSession {
    <#
.Synopsis
  Short description
.DESCRIPTION
  Long description
.EXAMPLE
  Example of how to use this cmdlet
.EXAMPLE
  Another example of how to use this cmdlet
.INPUTS
  Inputs to this cmdlet (if any)
.OUTPUTS
  Output from this cmdlet (if any)
.NOTES
  General notes
.COMPONENT
  The component this cmdlet belongs to
.ROLE
  The role this cmdlet belongs to
.FUNCTIONALITY
  The functionality that best describes this cmdlet
#>

    [CmdletBinding()]
    [Alias()]
    [OutputType([CimSession])]
    Param
    (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName, Position = 0)]
        [string[]]$ComputerName,

        [Parameter()]
        [ccmCimCredentialTransform()]
        [Microsoft.Management.Infrastructure.Options.CimCredential]$Credential
    )

    Begin {
        $option = [Microsoft.Management.Infrastructure.Options.DComSessionOptions]::new()
        if ($Credential) {
            $option.AddDestinationCredentials( $Credential )
        }
    }
    Process {
        ForEach ($a_ComputerName in $ComputerName) {
            [Microsoft.Management.Infrastructure.CimSession]::Create($a_ComputerName, $option)
        }
    }
    End {
    }
}