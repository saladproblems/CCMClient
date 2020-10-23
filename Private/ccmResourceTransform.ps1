class getVMTransformAttribute:System.Management.Automation.ArgumentTransformationAttribute {
    #This class is used in the parameter block of a function to transform objects into VMs. Primarily it's to make the VM field take either a name or a VM object
    
    [object] Transform([System.Management.Automation.EngineIntrinsics]$engineIntrinsics, [object]$object) {        
        $output = switch ($object) {
            { $PSItem -is [VMware.VimAutomation.ViCore.Impl.V1.VM.UniversalVirtualMachineImpl] } {
                $PSItem
                continue
            }
            { $PSItem -is [string] } {                
                Get-VM -Name $object
            }
        }
        return $output
    }
}