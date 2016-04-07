<#
.SYNOPSIS

Functions that assist with prompting and confirming a user regarding several
properties.

.PARAMETER PropertyAttributes

A hashtable the maps property names to their attributes. The supported 
attributes are the following:
    
    name - the name of the property
    description - the description of the property
    defaultValue - the default value of the property, if one exists.
    defaultPattern - the default pattern of the property, if one exists. Use
                     {0} through {n} for substitutions.
                     
.PARAMETER PromptOrder

A list of properties in the order in which they are to be presented. This has
two purposes:

    1. To present properties in an understandable order.
    2. To present substitution properties so they are ready for default
       patterns.
       
.PARAMETER PatternSubstitutions

A list of properties that are substituded, in-order, into the default patterns
to generate default values.
#>
Param(
    [Parameter(Position = 0, ParameterSetName="attr")]
    [PSObject]$Attributes = @{},
    
    [Parameter(ParameterSetName="Attr")]
    [string[]]$Order = [string[]]@(),
    
    [Parameter(ParameterSetName="Attr")]
    [string[]]$Substitutions = [string[]]@(),
    
    [Parameter(Position = 0, ParameterSetName="file")]
    [string]$PropertyFile
)

. .\res\strings.ps1
. .\Resources.ps1

<#
.SYNOPSIS

Prompt the user to enter each property in order.

.OUTPUT

A hashtable mapping properties to their value.
#>
function PromptUserForPropertyValues {
    Param(
        [PSObject]$Attributes,
        [string[]]$Order,
        [string[]]$Substitutions
    )

    $values = @{}

    foreach ($o in $Order) {
        $prop = $Attributes[$o]
        
        Write-Host ""
        
        Write-HostResource $strings.Prompts.PropName $prop.name
        Write-HostResource $strings.Prompts.PropDesc $prop.description
        Write-HostResource $strings.Prompts.PropExam $prop.example
        
        $defaultValue = $null
        if ($prop.defaultValue) {
            $defaultValue = $prop.defaultValue
        } elseif ($prop.defaultPattern) {
            $subs = $Substitutions | foreach { $values[$_] }
        
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

function PreparePromptProperties {
    switch ($PsCmdlet.ParameterSetName) {
        "attr" {
            if (!$Order) {
                $Order = $Attributes.GetEnumerator() | foreach {$_.Key}
            }
            if (!$Substitutions) {
                $Substitutions = [string[]]@()
            }
            
            return @{
                Attributes = $Attributes
                Order = $Order
                Substitutions = $Substitutions
            }
        } "file" {            
            . (Join-Path .\ $PropertyFile)
            
            return @{
                Attributes = $Attributes
                Order = $Order
                Substitutions = $Substitutions
            }
        }
    }
}

$PropertyDetails = PreparePromptProperties
PromptUserForPropertyValues $PropertyDetails.Attributes $PropertyDetails.Order $PropertyDetails.Substitutions