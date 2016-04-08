<#
.SYNOPSIS

Given a path to a script, return a query string that can be executed using
sqlcmd.

.PARAMETER Path

The path to the sql template.

.PARAMETER Properties

A hashtable of in which the key is the property name and the value is the
property value.

.OUTPUT

A query string that can be executes by sqlcmd.
#>
function Make-Script {
    Param(
        [string]$Path,
        [hashtable]$Properties
    )
    
    $template = (Get-Content $Path) -Join "`r`n"
    $script = $template
    foreach ($prop in $Properties.GetEnumerator()) {
        $script = $script -Replace [regex]::escape("<$($prop.Key)>"),"$($prop.Value)"
    }
    return $script
}