function Invoke-CCMClientComplianceSettingsEvaluation {
    [cmdletbinding()]

    param (
        [Parameter(ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            Position = 0,
            Mandatory
        )]
        [Microsoft.Management.Infrastructure.CimInstance[]]$CimInstance
    )

    process {
        foreach ($obj in $CimInstance) {
            Invoke-CimMethod -InputObject $obj -MethodName TriggerEvaluation -Arguments @{ Name = $obj.Name; version = $obj.Version }
        }
    }

}