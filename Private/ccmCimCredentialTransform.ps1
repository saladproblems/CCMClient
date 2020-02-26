class ccmCimCredentialTransform:System.Management.Automation.ArgumentTransformationAttribute {    
    [object] Transform([System.Management.Automation.EngineIntrinsics]$engineIntrinsics, [object]$object) {        
        $output = switch ($object) {
            { $PSItem -is [Microsoft.Management.Infrastructure.Options.CimCredential] } {
                $PSItem
            }
            { $PSItem -is [PSCredential] } {                
                $domain = $object.UserName -replace '.+@|\\.+'
                $UserName = $object.UserName -replace '.+\\|@.+'
                [Microsoft.Management.Infrastructure.Options.CimCredential]::new('Default', $domain, $UserName, $object.Password) 
            }
        }                    
        return $output
    }
}