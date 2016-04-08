. .\Make-Script.ps1

<#
.SYNOPSIS

Given a list of paths to sql templates, generate their scripts by substituting
property values.

.PARAMETER Paths

The paths to the sql templates.

.PARAMETER Properties

A hashtable of property names/values.

.OUTPUT

A list of scripts in the same order of the input templates.
#>
function Make-Scripts {
    Param(
        [string[]]$Paths,
        [hashtable]$Properties
    )
    
    [string[]]$scripts = @()
    foreach ($path in $Paths) {
        $scripts += (Make-Script $path $Properties)
    }
    return $scripts
}

Make-Scripts @(".\test.sql", ".\test2.sql") @{Database = "TestDB"; Table = "TestTable"; TempTable = "#TempTable"}