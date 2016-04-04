<#
.SYNOPSIS

Retain only folders that are older than, and only contain subfolders that are
older than, the specified number of months. If a folder has no date, it is
assumed to be old enough.
#>
function Filter-DatedFolderTreeByMinAgeInMonths {
    Param(
        [PSObject]$Tree,
        [int]$MinAge
    )
    
    $minDate = (Get-Date).AddMonths(-$MinAge)
    
    foreach ($node in $Tree) {
        if ($node.date) {
        
        }
    }
}