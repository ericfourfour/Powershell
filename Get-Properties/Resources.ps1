<#

#>
function Write-HostResource {
    Param(
        [PSObject]$Resource,
        [Object[]]$Substitutions = ""
    )
    
    if ($Resource.Color) {
        Write-Host "$([string]::Format($Resource.Value, $Substitutions))" -ForegroundColor ($Resource.Color)
    } else {
        Write-Host "$([string]::Format($Resource.Value, $Substitutions))"
    }
}

function Read-HostResource {
    Param(
        [PSObject]$Resource,
        [Object[]]$Substitutions
    )
    
    if ($Resource.Color) {
        return Read-Host "$([string]::Format($Resource.Value, $Substitutions))" -ForegroundColor ($Resource.Color)
    } else {
        return Read-Host "$([string]::Format($Resource.Value, $Substitutions))"
    }
}