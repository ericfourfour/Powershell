<#

#>

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

function TreesShouldMatch {
    Param(
        [PSObject]$Results,
        [PSObject]$Expected
    )
    
    #Write-Host "match <$($results.isOldEnough)> <$($Expected.isOldEnough)>"
    
    $results.isOldEnough | Should Be $Expected.isOldEnough
    
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

function Test-Mark-DatedFolderTree {
    Param(
        [PSObject]$Tree,
        [int]$MinAge,
        [PSObject]$Expected
    )
    
    $results = Mark-DatedFolderTreeByMinAgeInMonths $Tree $MinAge
    
    TreesShouldMatch $results $Expected
}

Describe "Mark-DatedFolderTree" {
    Mock Get-Date {
        New-Object DateTime(2016, 04, 05)
    }
    $minDate = New-Object DateTime(2015, 10, 05)

    . .\MarkTestTrees.ps1
    
    Context "Depth = 1; Dated folder" {
        It "Is old enough when equal to min date" {
            Test-Mark-DatedFolderTree $equalMinDateTree 6 $equalMinDateTreeExpected
        }
        It "Is old enough when older than min date" {
            Test-Mark-DatedFolderTree $olderMinDateTree 6 $olderMinDateTreeExpected
        }
        It "Is not old enough when younger than min date" {
            Test-Mark-DatedFolderTree $youngerMinDateTree 6 $youngerMinDateTreeExpected
        }
    }
    Context "Depth = 1; Undated folder" {
        It "Is not old enough" {
            Test-Mark-DatedFolderTree $undatedTree 6 $undatedTreeExpected
        }
    }
    Context "Depth = 2; Inner folder is older than min-date" {
        It "Is old enough when outer is older than min-date; outer is old enough" {
            Test-Mark-DatedFolderTree $innerOlderOuterOlder 6 $innerOlderOuterOlderExpected
        }
        It "Is old enough when outer is equal to min-date; outer is old enough" {
            Test-Mark-DatedFolderTree $innerOlderOuterEqual 6 $innerOlderOuterEqualExpected
        }
        It "Is old enough when outer is younger than min-date; outer is not old enough" {
            Test-Mark-DatedFolderTree $innerOlderOuterYounger 6 $innerOlderOuterYoungerExpected
        }
        It "Is old enough when outer is undated; outer is not old enough" {
            Test-Mark-DatedFolderTree $innerOlderOuterUndated 6 $innerOlderOuterUndatedExpected
        }
    }
    Context "Depth = 2; Inner folder is equal to min-date" {
        It "Is old enough when outer is older than min-date; outer is old enough" {
            Test-Mark-DatedFolderTree $innerEqualOuterOlder 6 $innerEqualOuterOlderExpected
        }
        It "Is old enough when outer is equal to min-date; outer is old enough" {
            Test-Mark-DatedFolderTree $innerEqualOuterEqual 6 $innerEqualOuterEqualExpected
        }
        It "Is old enough when outer is younger than min-date; outer is not old enough" {
            Test-Mark-DatedFolderTree $innerEqualOuterYounger 6 $innerEqualOuterYoungerExpected
        }
        It "Is old enough when outer is undated; outer is not old enough" {
            Test-Mark-DatedFolderTree $innerEqualOuterUndated 6 $innerEqualOuterUndatedExpected
        }
    }
    Context "Depth = 2; Inner folder is younger than min-date" {
        It "Is not old enough when outer is older than min-date; outer is not old enough" {
            Test-Mark-DatedFolderTree $innerYoungerOuterOlder 6 $innerYoungerOuterOlderExpected
        }
        It "Is not old enough when outer is equal to min-date; outer is not old enough" {
            Test-Mark-DatedFolderTree $innerYoungerOuterEqual 6 $innerYoungerOuterEqualExpected
        }
        It "Is not old enough when outer is younger than min-date; outer is not old enough" {
            Test-Mark-DatedFolderTree $innerYoungerOuterYounger 6 $innerYoungerOuterYoungerExpected
        }
        It "Is not old enough when outer is undated; outer is not old enough" {
            Test-Mark-DatedFolderTree $innerYoungerOuterUndated 6 $innerYoungerOuterUndatedExpected
        }
    }
    Context "Depth = 2; Inner folder is undated" {
        It "Is old enough when outer is older than min-date; outer is old enough" {
            Test-Mark-DatedFolderTree $innerUndatedOuterOlder 6 $innerUndatedOuterOlderExpected
        }
        It "Is old enough when outer is equal to min-date; outer is old enough" {
            Test-Mark-DatedFolderTree $innerUndatedOuterEqual 6 $innerUndatedOuterEqualExpected
        }
        It "Is not old enough when outer is younger than min-date; outer is not old enough" {
            Test-Mark-DatedFolderTree $innerUndatedOuterYounger 6 $innerUndatedOuterYoungerExpected
        }
        It "Is not old enough when outer is undated; outer is not old enough" {
            Test-Mark-DatedFolderTree $innerUndatedOuterUndated 6 $innerUndatedOuterUndatedExpected
        }
    }
    Context "Depth = 2; Inner folders are older than min-date" {
        It "Are old enough when outer is older than min-date; outer is old enough" {
            Test-Mark-DatedFolderTree $innersOlderOuterOlder 6 $innersOlderOuterOlderExpected
        }
        It "Are old enough when outer is equal to min-date; outer is old enough" {
            Test-Mark-DatedFolderTree $innersOlderOuterEqual 6 $innersOlderOuterEqualExpected
        }
        It "Are old enough when outer is younger than min-date; outer is not old enough" {
            Test-Mark-DatedFolderTree $innersOlderOuterYounger 6 $innersOlderOuterYoungerExpected
        }
        It "Are old enough when outer is undated; outer is not old enough" {
            Test-Mark-DatedFolderTree $innersOlderOuterUndated 6 $innersOlderOuterUndatedExpected
        }
    }
    Context "Depth = 2; Inner folders are equal to min-date" {
        It "Are old enough when outer is older than min-date; outer is old enough" {
            Test-Mark-DatedFolderTree $innersEqualOuterOlder 6 $innersEqualOuterOlderExpected
        }
        It "Are old enough when outer is equal to min-date; outer is old enough" {
            Test-Mark-DatedFolderTree $innersEqualOuterEqual 6 $innersEqualOuterEqualExpected
        }
        It "Are old enough when outer is younger than min-date; outer is not old enough" {
            Test-Mark-DatedFolderTree $innersEqualOuterYounger 6 $innersEqualOuterYoungerExpected
        }
        It "Are old enough when outer is undated; outer is not old enough" {
            Test-Mark-DatedFolderTree $innersEqualOuterUndated 6 $innersEqualOuterUndatedExpected
        }
    }
    Context "Depth = 2; Inner folders are younger than min-date" {
        It "Are not old enough when outer is older than min-date; outer is not old enough" {
            Test-Mark-DatedFolderTree $innersYoungerOuterOlder 6 $innersYoungerOuterOlderExpected
        }
        It "Are not old enough when outer is equal to min-date; outer is not old enough" {
            Test-Mark-DatedFolderTree $innersYoungerOuterEqual 6 $innersYoungerOuterEqualExpected
        }
        It "Are not old enough when outer is younger than min-date; outer is not old enough" {
            Test-Mark-DatedFolderTree $innersYoungerOuterYounger 6 $innersYoungerOuterYoungerExpected
        }
        It "Are not old enough when outer is undated; outer is not old enough" {
            Test-Mark-DatedFolderTree $innersYoungerOuterUndated 6 $innersYoungerOuterUndatedExpected
        }
    }
    Context "Depth = 2; Inner folders are undated" {
        It "Are old enough when outer is older than min-date; outer is old enough" {
            Test-Mark-DatedFolderTree $innersUndatedOuterOlder 6 $innersUndatedOuterOlderExpected
        }
        It "Are old enough when outer is equal to min-date; outer is old enough" {
            Test-Mark-DatedFolderTree $innersUndatedOuterEqual 6 $innersUndatedOuterEqualExpected
        }
        It "Are not old enough when outer is younger than min-date; outer is not old enough" {
            Test-Mark-DatedFolderTree $innersUndatedOuterYounger 6 $innersUndatedOuterYoungerExpected
        }
        It "Are not old enough when outer is undated; outer is not old enough" {
            Test-Mark-DatedFolderTree $innersUndatedOuterUndated 6 $innersUndatedOuterUndatedExpected
        }
    }
    Context "Depth = 2; Inner folders are older than and equal to min-date" {
        It "Are old enough when outer is older than min-date; outer is old enough" {
            Test-Mark-DatedFolderTree $innersOlderAndEqualOuterOlder 6 $innersOlderAndEqualOuterOlderExpected
        }
        It "Are old enough when outer is equal to min-date; outer is old enough" {
            Test-Mark-DatedFolderTree $innersOlderAndEqualOuterEqual 6 $innersOlderAndEqualOuterEqualExpected
        }
        It "Are old enough when outer is younger than min-date; outer is not old enough" {
            Test-Mark-DatedFolderTree $innersOlderAndEqualOuterYounger 6 $innersOlderAndEqualOuterYoungerExpected
        }
        It "Are old enough when outer is undated; outer is not old enough" {
            Test-Mark-DatedFolderTree $innersOlderAndEqualOuterUndated 6 $innersOlderAndEqualOuterUndatedExpected
        }
    }
    Context "Depth = 2; Inner folders are older and younger than min-date" {
        It "Are not old enough when outer is older than min-date; outer is not old enough" {
            Test-Mark-DatedFolderTree $innersOlderAndYoungerOuterOlder 6 $innersOlderAndYoungerOuterOlderExpected
        }
        It "Are not old enough when outer is equal to min-date; outer is not old enough" {
            Test-Mark-DatedFolderTree $innersOlderAndYoungerOuterEqual 6 $innersOlderAndYoungerOuterEqualExpected
        }
        It "Are not old enough when outer is younger than min-date; outer is not old enough" {
            Test-Mark-DatedFolderTree $innersOlderAndYoungerOuterYounger 6 $innersOlderAndYoungerOuterYoungerExpected
        }
        It "Are not old enough when outer is undated; outer is not old enough" {
            Test-Mark-DatedFolderTree $innersOlderAndYoungerOuterUndated 6 $innersOlderAndYoungerOuterUndatedExpected
        }
    }
    Context "Depth = 2; Inner folders are older than min-date and undated" {
        It "Are old enough when outer is older than min-date; outer is old enough" {
            Test-Mark-DatedFolderTree $innersOlderAndUndatedOuterOlder 6 $innersOlderAndUndatedOuterOlderExpected
        }
        It "Are old enough when outer is equal to min-date; outer is old enough" {
            Test-Mark-DatedFolderTree $innersOlderAndUndatedOuterEqual 6 $innersOlderAndUndatedOuterEqualExpected
        }
        It "Are not old enough when outer is younger than min-date; outer is not old enough" {
            Test-Mark-DatedFolderTree $innersOlderAndUndatedOuterYounger 6 $innersOlderAndUndatedOuterYoungerExpected
        }
        It "Are not old enough when outer is undated; outer is not old enough" {
            Test-Mark-DatedFolderTree $innersOlderAndUndatedOuterUndated 6 $innersOlderAndUndatedOuterUndatedExpected
        }
    }
    Context "Depth = 2; Inner folders are equal to and younger than min-date" {
        It "Are not old enough when outer is older than min-date; outer is not old enough" {
            Test-Mark-DatedFolderTree $innersEqualAndYoungerOuterOlder 6 $innersEqualAndYoungerOuterOlderExpected
        }
        It "Are not old enough when outer is equal to min-date; outer is not old enough" {
            Test-Mark-DatedFolderTree $innersEqualAndYoungerOuterEqual 6 $innersEqualAndYoungerOuterEqualExpected
        }
        It "Are not old enough when outer is younger than min-date; outer is not old enough" {
            Test-Mark-DatedFolderTree $innersEqualAndYoungerOuterYounger 6 $innersEqualAndYoungerOuterYoungerExpected
        }
        It "Are not old enough when outer is undated; outer is not old enough" {
            Test-Mark-DatedFolderTree $innersEqualAndYoungerOuterUndated 6 $innersEqualAndYoungerOuterUndatedExpected
        }
    }
    Context "Depth = 2; Inner folders are equal to min-date and undated" {
        It "Are old enough when outer is older than min-date; outer is old enough" {
            Test-Mark-DatedFolderTree $innersEqualAndUndatedOuterOlder 6 $innersEqualAndUndatedOuterOlderExpected
        }
        It "Are old enough when outer is equal to min-date; outer is old enough" {
            Test-Mark-DatedFolderTree $innersEqualAndUndatedOuterEqual 6 $innersEqualAndUndatedOuterEqualExpected
        }
        It "Are not old enough when outer is younger than min-date; outer is not old enough" {
            Test-Mark-DatedFolderTree $innersEqualAndUndatedOuterYounger 6 $innersEqualAndUndatedOuterYoungerExpected
        }
        It "Are not old enough when outer is undated; outer is not old enough" {
            Test-Mark-DatedFolderTree $innersEqualAndUndatedOuterUndated 6 $innersEqualAndUndatedOuterUndatedExpected
        }
    }
    Context "Depth = 2; Inner folders are younger than min-date and undated" {
        It "When outer is older than min-date, undated are old enough, dated are not old enough, and outer is not old enough" {
            Test-Mark-DatedFolderTree $innersYoungerAndUndatedOuterOlder 6 $innersYoungerAndUndatedOuterOlderExpected
        }
        It "When outer is equal to min-date, undated are old enough, dated are not old enough, and outer is not old enough" {
            Test-Mark-DatedFolderTree $innersYoungerAndUndatedOuterEqual 6 $innersYoungerAndUndatedOuterEqualExpected
        }
        It "Are not old enough when outer is younger than min-date; outer is not old enough" {
            Test-Mark-DatedFolderTree $innersYoungerAndUndatedOuterYounger 6 $innersYoungerAndUndatedOuterYoungerExpected
        }
        It "Are not old enough when outer is undated; outer is not old enough" {
            Test-Mark-DatedFolderTree $innersYoungerAndUndatedOuterUndated 6 $innersYoungerAndUndatedOuterUndatedExpected
        }
    }
    
    Context "Depth = 3; Inner older (O); Middle older (O)" {
        It "Outer older (O): TTT (true, true, true) (inner, middle, outer)" {
            Test-Mark-DatedFolderTree $innerOlderMiddleOlderOuterOlder 6 $innerOlderMiddleOlderOuterOlderExpected
        }
        It "Outer equal (E): TTT" {
            Test-Mark-DatedFolderTree $innerOlderMiddleOlderOuterEqual 6 $innerOlderMiddleOlderOuterEqualExpected
        }
        It "Outer younger (Y): TTF (true, true, false)" {
            Test-Mark-DatedFolderTree $innerOlderMiddleOlderOuterYounger 6 $innerOlderMiddleOlderOuterYoungerExpected
        }
        It "Outer undated (U): TTF" {
            Test-Mark-DatedFolderTree $innerOlderMiddleOlderOuterUndated 6 $innerOlderMiddleOlderOuterUndatedExpected
        }
        
    }
    Context "Depth = 3; OE" {
        It "O: TTT" {
            Test-Mark-DatedFolderTree $innerOlderMiddleEqualOuterOlder 6 $innerOlderMiddleEqualOuterOlderExpected
        }
        It "E: TTT" {
            Test-Mark-DatedFolderTree $innerOlderMiddleEqualOuterEqual 6 $innerOlderMiddleEqualOuterEqualExpected
        }
        It "Y: TTF" {
            Test-Mark-DatedFolderTree $innerOlderMiddleEqualOuterYounger 6 $innerOlderMiddleEqualOuterYoungerExpected
        }
        It "U: TTF" {
            Test-Mark-DatedFolderTree $innerOlderMiddleEqualOuterUndated 6 $innerOlderMiddleEqualOuterUndatedExpected
        }
        
    }
    Context "Depth = 3; OY" {
        It "O: TFF" {
            Test-Mark-DatedFolderTree $innerOlderMiddleYoungerOuterOlder 6 $innerOlderMiddleYoungerOuterOlderExpected
        }
        It "E: TFF" {
            Test-Mark-DatedFolderTree $innerOlderMiddleYoungerOuterEqual 6 $innerOlderMiddleYoungerOuterEqualExpected
        }
        It "Y: TFF" {
            Test-Mark-DatedFolderTree $innerOlderMiddleYoungerOuterYounger 6 $innerOlderMiddleYoungerOuterYoungerExpected
        }
        It "U: TFF" {
            Test-Mark-DatedFolderTree $innerOlderMiddleYoungerOuterUndated 6 $innerOlderMiddleYoungerOuterUndatedExpected
        }
        
    }
    Context "Depth = 3; OU" {
        It "O: TTT" {
            Test-Mark-DatedFolderTree $innerOlderMiddleUndatedOuterOlder 6 $innerOlderMiddleUndatedOuterOlderExpected
        }
        It "E: TTT" {
            Test-Mark-DatedFolderTree $innerOlderMiddleUndatedOuterEqual 6 $innerOlderMiddleUndatedOuterEqualExpected
        }
        It "Y: TFF" {
            Test-Mark-DatedFolderTree $innerOlderMiddleUndatedOuterYounger 6 $innerOlderMiddleUndatedOuterYoungerExpected
        }
        It "U: TFF" {
            Test-Mark-DatedFolderTree $innerOlderMiddleUndatedOuterUndated 6 $innerOlderMiddleUndatedOuterUndatedExpected
        }
        
    }
    
    Context "Depth = 3; EO" {
        It "O: TTT" {
            Test-Mark-DatedFolderTree $innerEqualMiddleOlderOuterOlder 6 $innerEqualMiddleOlderOuterOlderExpected
        }
        It "E: TTT" {
            Test-Mark-DatedFolderTree $innerEqualMiddleOlderOuterEqual 6 $innerEqualMiddleOlderOuterEqualExpected
        }
        It "Y: TTF" {
            Test-Mark-DatedFolderTree $innerEqualMiddleOlderOuterYounger 6 $innerEqualMiddleOlderOuterYoungerExpected
        }
        It "U: TTF" {
            Test-Mark-DatedFolderTree $innerEqualMiddleOlderOuterUndated 6 $innerEqualMiddleOlderOuterUndatedExpected
        }
        
    }
    Context "Depth = 3; EE" {
        It "O: TTT" {
            Test-Mark-DatedFolderTree $innerEqualMiddleEqualOuterOlder 6 $innerEqualMiddleEqualOuterOlderExpected
        }
        It "E: TTT" {
            Test-Mark-DatedFolderTree $innerEqualMiddleEqualOuterEqual 6 $innerEqualMiddleEqualOuterEqualExpected
        }
        It "Y: TTF" {
            Test-Mark-DatedFolderTree $innerEqualMiddleEqualOuterYounger 6 $innerEqualMiddleEqualOuterYoungerExpected
        }
        It "U: TTF" {
            Test-Mark-DatedFolderTree $innerEqualMiddleEqualOuterUndated 6 $innerEqualMiddleEqualOuterUndatedExpected
        }
        
    }
    Context "Depth = 3; EY" {
        It "O: TFF" {
            Test-Mark-DatedFolderTree $innerEqualMiddleYoungerOuterOlder 6 $innerEqualMiddleYoungerOuterOlderExpected
        }
        It "E: TFF" {
            Test-Mark-DatedFolderTree $innerEqualMiddleYoungerOuterEqual 6 $innerEqualMiddleYoungerOuterEqualExpected
        }
        It "Y: TFF" {
            Test-Mark-DatedFolderTree $innerEqualMiddleYoungerOuterYounger 6 $innerEqualMiddleYoungerOuterYoungerExpected
        }
        It "U: TFF" {
            Test-Mark-DatedFolderTree $innerEqualMiddleYoungerOuterUndated 6 $innerEqualMiddleYoungerOuterUndatedExpected
        }
        
    }
    Context "Depth = 3; EU" {
        It "O: TTT" {
            Test-Mark-DatedFolderTree $innerEqualMiddleUndatedOuterOlder 6 $innerEqualMiddleUndatedOuterOlderExpected
        }
        It "E: TTT" {
            Test-Mark-DatedFolderTree $innerEqualMiddleUndatedOuterEqual 6 $innerEqualMiddleUndatedOuterEqualExpected
        }
        It "Y: TFF" {
            Test-Mark-DatedFolderTree $innerEqualMiddleUndatedOuterYounger 6 $innerEqualMiddleUndatedOuterYoungerExpected
        }
        It "U: TFF" {
            Test-Mark-DatedFolderTree $innerEqualMiddleUndatedOuterUndated 6 $innerEqualMiddleUndatedOuterUndatedExpected
        }
        
    }

    Context "Depth = 3; YO" {
        It "O: FFF" {
            Test-Mark-DatedFolderTree $innerYoungerMiddleOlderOuterOlder 6 $innerYoungerMiddleOlderOuterOlderExpected
        }
        It "E: FFF" {
            Test-Mark-DatedFolderTree $innerYoungerMiddleOlderOuterEqual 6 $innerYoungerMiddleOlderOuterEqualExpected
        }
        It "Y: FFF" {
            Test-Mark-DatedFolderTree $innerYoungerMiddleOlderOuterYounger 6 $innerYoungerMiddleOlderOuterYoungerExpected
        }
        It "U: FFF" {
            Test-Mark-DatedFolderTree $innerYoungerMiddleOlderOuterUndated 6 $innerYoungerMiddleOlderOuterUndatedExpected
        }
        
    }
    Context "Depth = 3; YE" {
        It "O: FFF" {
            Test-Mark-DatedFolderTree $innerYoungerMiddleEqualOuterOlder 6 $innerYoungerMiddleEqualOuterOlderExpected
        }
        It "E: FFF" {
            Test-Mark-DatedFolderTree $innerYoungerMiddleEqualOuterEqual 6 $innerYoungerMiddleEqualOuterEqualExpected
        }
        It "Y: FFF" {
            Test-Mark-DatedFolderTree $innerYoungerMiddleEqualOuterYounger 6 $innerYoungerMiddleEqualOuterYoungerExpected
        }
        It "U: FFF" {
            Test-Mark-DatedFolderTree $innerYoungerMiddleEqualOuterUndated 6 $innerYoungerMiddleEqualOuterUndatedExpected
        }
        
    }
    Context "Depth = 3; YY" {
        It "O: FFF" {
            Test-Mark-DatedFolderTree $innerYoungerMiddleYoungerOuterOlder 6 $innerYoungerMiddleYoungerOuterOlderExpected
        }
        It "E: FFF" {
            Test-Mark-DatedFolderTree $innerYoungerMiddleYoungerOuterEqual 6 $innerYoungerMiddleYoungerOuterEqualExpected
        }
        It "Y: FFF" {
            Test-Mark-DatedFolderTree $innerYoungerMiddleYoungerOuterYounger 6 $innerYoungerMiddleYoungerOuterYoungerExpected
        }
        It "U: FFF" {
            Test-Mark-DatedFolderTree $innerYoungerMiddleYoungerOuterUndated 6 $innerYoungerMiddleYoungerOuterUndatedExpected
        }
        
    }
    Context "Depth = 3; YU" {
        It "O: FFF" {
            Test-Mark-DatedFolderTree $innerYoungerMiddleUndatedOuterOlder 6 $innerYoungerMiddleUndatedOuterOlderExpected
        }
        It "E: FFF" {
            Test-Mark-DatedFolderTree $innerYoungerMiddleUndatedOuterEqual 6 $innerYoungerMiddleUndatedOuterEqualExpected
        }
        It "Y: FFF" {
            Test-Mark-DatedFolderTree $innerYoungerMiddleUndatedOuterYounger 6 $innerYoungerMiddleUndatedOuterYoungerExpected
        }
        It "U: FFF" {
            Test-Mark-DatedFolderTree $innerYoungerMiddleUndatedOuterUndated 6 $innerYoungerMiddleUndatedOuterUndatedExpected
        }
        
    }

    Context "Depth = 3; UO" {
        It "O: TTT" {
            Test-Mark-DatedFolderTree $innerUndatedMiddleOlderOuterOlder 6 $innerUndatedMiddleOlderOuterOlderExpected
        }
        It "E: TTT" {
            Test-Mark-DatedFolderTree $innerUndatedMiddleOlderOuterEqual 6 $innerUndatedMiddleOlderOuterEqualExpected
        }
        It "Y: TTF" {
            Test-Mark-DatedFolderTree $innerUndatedMiddleOlderOuterYounger 6 $innerUndatedMiddleOlderOuterYoungerExpected
        }
        It "U: TTF" {
            Test-Mark-DatedFolderTree $innerUndatedMiddleOlderOuterUndated 6 $innerUndatedMiddleOlderOuterUndatedExpected
        }
        
    }
    Context "Depth = 3; UE" {
        It "O: TTT" {
            Test-Mark-DatedFolderTree $innerUndatedMiddleEqualOuterOlder 6 $innerUndatedMiddleEqualOuterOlderExpected
        }
        It "E: TTT" {
            Test-Mark-DatedFolderTree $innerUndatedMiddleEqualOuterEqual 6 $innerUndatedMiddleEqualOuterEqualExpected
        }
        It "Y: TTF" {
            Test-Mark-DatedFolderTree $innerUndatedMiddleEqualOuterYounger 6 $innerUndatedMiddleEqualOuterYoungerExpected
        }
        It "U: TTF" {
            Test-Mark-DatedFolderTree $innerUndatedMiddleEqualOuterUndated 6 $innerUndatedMiddleEqualOuterUndatedExpected
        }
        
    }
    Context "Depth = 3; UY" {
        It "O: FFF" {
            Test-Mark-DatedFolderTree $innerUndatedMiddleYoungerOuterOlder 6 $innerUndatedMiddleYoungerOuterOlderExpected
        }
        It "E: FFF" {
            Test-Mark-DatedFolderTree $innerUndatedMiddleYoungerOuterEqual 6 $innerUndatedMiddleYoungerOuterEqualExpected
        }
        It "Y: FFF" {
            Test-Mark-DatedFolderTree $innerUndatedMiddleYoungerOuterYounger 6 $innerUndatedMiddleYoungerOuterYoungerExpected
        }
        It "U: FFF" {
            Test-Mark-DatedFolderTree $innerUndatedMiddleYoungerOuterUndated 6 $innerUndatedMiddleYoungerOuterUndatedExpected
        }
        
    }
    Context "Depth = 3; UU" {
        It "O: TTT" {
            Test-Mark-DatedFolderTree $innerUndatedMiddleUndatedOuterOlder 6 $innerUndatedMiddleUndatedOuterOlderExpected
        }
        It "E: TTT" {
            Test-Mark-DatedFolderTree $innerUndatedMiddleUndatedOuterEqual 6 $innerUndatedMiddleUndatedOuterEqualExpected
        }
        It "Y: FFF" {
            Test-Mark-DatedFolderTree $innerUndatedMiddleUndatedOuterYounger 6 $innerUndatedMiddleUndatedOuterYoungerExpected
        }
        It "U: FFF" {
            Test-Mark-DatedFolderTree $innerUndatedMiddleUndatedOuterUndated 6 $innerUndatedMiddleUndatedOuterUndatedExpected
        }
        
    }

}