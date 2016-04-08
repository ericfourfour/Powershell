<#
Filter out all nodes in the tree whos parents have the flag oldEnough = $true.
#>
function Filter-DatedFolderTreeByAge {
    Param(
        [PSObject]$Tree
    )
    
    $filteredTree = $Tree
    
    if ($Tree.isOldEnough) {
        $filteredTree.subfolders = $null
    }
}