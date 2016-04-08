. .\res\strings.ps1
. .\Resources.ps1

function Prompt-Values {
    <#
    .SYNOPSIS

    Prompt the user to enter each property in order.

    .OUTPUT

    A hashtable mapping properties to their value.
    #>
    Param(
        [hashtable]$ProprtyConfiguration
    )

    $values = @{}

    foreach ($o in $ProprtyConfiguration.Order) {
        $prop = $ProprtyConfiguration.Attributes[$o]
        
        Write-Host ""
        
        Write-HostResource $strings.Prompts.PropName $prop.name
        Write-HostResource $strings.Prompts.PropDesc $prop.description
        Write-HostResource $strings.Prompts.PropExam $prop.example
        
        $defaultValue = $null
        if ($prop.defaultValue) {
            $defaultValue = $prop.defaultValue
        } elseif ($prop.defaultPattern) {
            $subs = $ProprtyConfiguration.Substitutions | foreach { $values[$_] }
        
            $defaultValue = [string]::Format($prop.defaultPattern, $subs)
        }
        
        if ($defaultValue) {
            Write-HostResource $strings.Prompts.PropDefVal $defaultValue
        }
        
        $input = ""
        while ($input -eq "") {
            $input = Read-HostResource $strings.Prompts.PropReadVal
            
            if ($input -eq "") {
                if ($defaultValue) {
                    $input = $defaultValue
                } else {
                    Write-HostResource $strings.Prompts.PropBlankVal
                }
            }
        }
        
        $values[$o] = $input;
    }
    
    return $values
}
