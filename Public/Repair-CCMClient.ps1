function Repair-CCMClient {
    [cmdletbinding()]
    
    param(
        [string[]]$ComputerName
    )
        begin {
            $cimParam = @{
                NameSpace = 'root\ccm'
                ClassName = 'sms_client'
                Method = 'RepairClient'
                CimSession = [System.Collections.Generic.List[cimsession]]::new()
            }
        }
    
        process {
            $cimParam.CimSession.AddRange( [cimsession[]](New-CCMClientCimSession -ComputerName $ComputerName) )        
        }
    
        end {
            Invoke-CimMethod @cimParam
        }
    
    }