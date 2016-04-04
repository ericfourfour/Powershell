<#
.SYNOPSIS

Parse the date prefix from the folder name.

.DESCRIPTION

Parses the date prefix that has one of the following forms: yyyy, yyyyMM,
yyyyMMdd.

If the date is in yyyy form, it will return the last date of that year. If it
is in yyyyMMdd form, it will return the last date of that month. If it is in
yyyyMMdd it will return that date.

.PARAMETER FolderName

The leaf of the folder path.

.OUTPUT

Returns a .NET DateTime object representing the parsed date.
#>
function Get-DatePartFromFolderName {
    Param(
        [string]$FolderName
    )
    
    # yyyy, yyyyMM, yyyyMMdd prefix lengths
    $prefixLengths = @(4, 6, 8)
    
    $dateString = ""
    foreach ($p in $prefixLengths) {
        if ($FolderName -match "^[0-9]{$p}(([^0-9]+).*)?$") {
            $dateString = $FolderName.SubString(0, $p)
            break
        }
    }
    
    $year = -1
    $month = -1
    $day = -1
    
    if ($dateString.Length -ge 4) {
        $year = [int]$DateString.SubString(0, 4)
    }
    if ($dateString.Length -ge 6) {
        $month = [int]$DateString.SubString(4, 2)
    }
    if ($dateString.Length -eq 8) {
        $day = [int]$DateString.SubString(6, 2)
    }
    
    if ($year -ne -1) {
        if ($month -eq -1) {
            $month = 12
        }
        if ($day -eq -1 -and $month -ge 1 -and $month -le 12) {
            $day = [DateTime]::DaysInMonth($year, $month)
        }
    }
    
    try {
        New-Object System.DateTime($year, $month, $day)
    } catch {
        $null
    }
}