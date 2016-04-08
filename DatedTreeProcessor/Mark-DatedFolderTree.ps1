<#
.SYNOPSIS

Go through the tree and mark whether the folder is older than the specified
date. If a folder has no date, it inherits the status of its parent. If its
parent has no date, then it is assumed not old enough.

.OUTPUT

Returns the same tree except with the isOldEnough (boolean) property added.
#>
function Mark-DatedFolderTreeByMinAgeInMonths {
    Param(
        [PSObject]$Tree,
        [int]$MinAge,
        [System.Nullable[[DateTime]]]$ParentDate = $null
    )
    
    $minDate = (Get-Date).AddMonths(-$MinAge)
    
    $PassDownDate = $Tree.date
    
    if ($Tree.date -eq $null) {
        if ($ParentDate -eq $null) {
            $Tree["isOldEnough"] = $false
        } else {
            $Tree["isOldEnough"] = ($ParentDate -le $minDate)
            $PassDownDate = $ParentDate
        }
    } else {
        $Tree["isOldEnough"] = $Tree.Date -le $minDate
    }
    
    $allOldEnough = $true
    
    if ($Tree.subfolders) {
        
        if ($Tree.subfolders.GetType() -eq [Object[]]) {
            foreach ($node in $Tree.subfolders) {
                $results = Mark-DatedFolderTreeByMinAgeInMonths $node $MinAge $PassDownDate
                
                if (!$node.isOldEnough) {
                    $allOldEnough = $false
                }
            }
        } elseif ($Tree.subfolders.GetType() -eq [Hashtable]) {
            $results = Mark-DatedFolderTreeByMinAgeInMonths ($Tree.subfolders) $MinAge $PassDownDate
            
            if (!$Tree.subfolders.isOldEnough) {
                $allOldEnough = $false
            }
        }
    }
    
    if (!$allOldEnough) {
        $Tree["isOldEnough"] = $false
    }
        
    return $Tree
}