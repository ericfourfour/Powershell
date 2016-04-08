<#

#>
function Get-OutputString {
    Param(
        [PSObject]$Resource,
        [Object[]]$Substitutions
    )

    $outString = ""
    if ($Substitutions) {
        $outString = "$([string]::Format($Resource.Value, $Substitutions))"
    } else {
        $outString = "$($Resource.Value)"
    }
    return $outString
}

function Write-HostResource {
    Param(
        [PSObject]$Resource,
        [Object[]]$Substitutions = ""
    )
    
    $outString = Get-OutputString $Resource $Substitutions
    if ($Resource.Color) {
        Write-Host "$outString" -ForegroundColor ($Resource.Color)
    } else {
        Write-Host "$outString"
    }
}

function Read-HostResource {
    Param(
        [PSObject]$Resource,
        [Object[]]$Substitutions = ""
    )
    
    $outString = Get-OutputString $Resource $Substitutions
    if ($Resource.Color) {
        return Read-Host "$outString" -ForegroundColor ($Resource.Color)
    } else {
        return Read-Host "$outString"
    }
}