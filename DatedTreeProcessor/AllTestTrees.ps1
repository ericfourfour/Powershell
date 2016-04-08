<#

#>
$trees = @{
    depth = @{
        
    }
}

$depthPath = Resolve-Path ".\TestTrees"
$depths = @(1, 2, 3)

foreach ($folder in (Get-ChildItem $depthPath)) {
    $depth = ($folder.Name -split " ")[1]
    $trees.depth["$depth"] = @{
        path = (Join-Path $depthPath $folder);
    }
}

$trees.depth.GetEnumerator() | foreach { Write-Host "$($_.Key) $($_.Value.path)" }