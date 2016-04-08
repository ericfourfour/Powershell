<#

#>

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

. .\TestTrees.ps1

function TreesShouldMatch {
    Param(
        [PSObject]$Results,
        [PSObject]$Expected
    )
        
    $results.path | Should be "$($Expected.path)"
    $results.date | Should be $Expected.date
    
    if ($Results.subfolders -eq $null) {
        $Results.subfolders | Should Be $Expected.subfolders
    } elseif ($Results.subfolders.GetType() -eq [Object[]]) {
        for ($i = 0; $i -lt $Results.subfolders.Length; $i++) {
            TreesShouldMatch $Results.subfolders[$i] $Expected.subfolders[$i]
        }
    } elseif ($Results.subfolders.GetType() -eq [Hashtable]) {
        TreesShouldMatch $Results.subfolders $Expected.subfolders
    }
}

function Test-Get-DatedFolderTree {
    Param(
        [string]$RootPath,
        [PSObject]$Expected
    )
    
    $results = Get-DatedFolderTree $RootPath
    
    TreesShouldMatch $results $Expected
}

Describe "Get-DatedFolderTree" {
  
    Context "Tree Depth = 1" {
        It "Has no subfolders" {
            Test-Get-DatedFolderTree $depth1DatePath $depth1DateTree
        }
        It "Has date on valid date prefix" {
            Test-Get-DatedFolderTree $depth1DatePath $depth1DateTree
        }
        It "Has null date on no date prefix" {
            Test-Get-DatedFolderTree $depth1NoDatePath $depth1NoDateTree
        }
    }
    Context "Tree Depth = 2" {
        It "Has subfolders" {
            Test-Get-DatedFolderTree $depth2DatePath $depth2DateTree
        }
    }
    Context "Tree Depth = 3" {
        It "Has subfolders" {
            Test-Get-DatedFolderTree $depth3SomeDatesPath $depth3SomeDatesTree
        }
    }
    Context "Full Test Tree" {
        It "Matches" {
            Test-Get-DatedFolderTree $fullTestPath $fullTestTree
        }
    }
}