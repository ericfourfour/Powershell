. .\Date-Tools.ps1

<#
.SYNOPSIS

Given a path to the root folder, return the folder tree.

.OUTPUT

Return a PSObject with the following properties: path, date, subfolders
#>
function Get-DatedFolderTree {
    Param(
        [string]$RootPath
    )
    $path = Resolve-Path $RootPath
    
    $date = Get-DatePartFromFolderName (Split-Path $path -Leaf)
    $childPaths = (Get-ChildItem $path) | Where-Object { $_.Mode -like "d*" } | ForEach-Object { Join-Path $path $_ }
    
    if ($childPaths -ne $null) {
        $subfolders = $childPaths | ForEach-Object {Get-DatedFolderTree $_}
    }
    
    return @{
        path = $path;
        date = $date;
        subfolders = $subfolders;
    }
}