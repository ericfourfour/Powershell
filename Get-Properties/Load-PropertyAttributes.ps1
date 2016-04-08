function Load-PropertyAttributes {
    <#
    
    #>
    Param(
        [string]$PropertyFile
    )
    
    . (Join-Path .\ $PropertyFile)
            
    return @{
        Attributes = $Attributes
        Order = $Order
        Substitutions = $Substitutions
    }
}