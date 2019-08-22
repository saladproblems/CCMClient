function ConvertTo-CCMClientCimCredential {
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
   [OutputType([Microsoft.Management.Infrastructure.Options.CimCredential])]
   Param
   (
       [Parameter(Mandatory, Position = 0, ValueFromPipeline)]
       [PSCredential]$Credential
   )
       
   process {        
       $domain = $Credential.UserName -replace '.+@|\\.+'
       $UserName = $Credential.UserName -replace '.+\\|@.+'
       [Microsoft.Management.Infrastructure.Options.CimCredential]::new('Default', $domain, $UserName, $Credential.Password)        
   }
}