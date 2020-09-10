class ccmClient {
    [ciminstance] static getClientCimInstance (
        [string]$ClassName,
        [string]$NameSpace
    ){
        return (Get-Ciminstance -NameSpace $NameSpace -ClassName $ClassName)
    }
    [ciminstance[]] static getClientCimInstance (
        [string]$ClassName,
        [string]$NameSpace,
        [string[]]$ComputerName
    ){
        return (Get-Ciminstance -ComputerName $ComputerName -NameSpace $NameSpace -ClassName $ClassName)
    }
    [ciminstance[]] static getClientCimInstance (
        [string]$ClassName,
        [string]$NameSpace,
        [CimSession[]]$CimSession
    ){
        return (Get-Ciminstance -CimSession $CimSession -NameSpace $NameSpace -ClassName $ClassName)
    }
    [ciminstance[]] static getClientCimInstance (
        [CimInstance[]]$CimInstance
    ){
        return ($CimInstance | Get-Ciminstance)
    }
}