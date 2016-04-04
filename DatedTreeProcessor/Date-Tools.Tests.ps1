<#

#>

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"


function Get-ExpectedDatePart {
    Param(
        [int]$year = 1,
        [int]$month = 1,
        [int]$day = 1
    )
    
    return New-Object System.DateTime($year, $month, $day)
}

function Test-Get-DatePartFromFolderName {
    Param(
        [string]$FolderName,
        [int]$Year = 1,
        [int]$Month = 1,
        [int]$Day = 1
    )
    
    $results = Get-DatePartFromFolderName $FolderName
    
    $results | Should Be (Get-ExpectedDatePart $Year $Month $Day)
}

function NoMatchTest-Get-DatePartFromFolderName {
    Param(
        [string]$FolderName
    )
    
    $results = Get-DatePartFromFolderName $FolderName
    $results | Should Be $null
}

Describe "Get-DatePartFromFolderName" {
    Context "yyyy" {
        It "Matches yyyy at start of string" {
            Test-Get-DatePartFromFolderName "2016 - Foo" 2016 12 31
            Test-Get-DatePartFromFolderName "2015" 2015 12 31
        }
        It "Doesn't match yyyy not at start of string" {
            NoMatchTest-Get-DatePartFromFolderName " 2016 - Foo"
            NoMatchTest-Get-DatePartFromFolderName " 2015"
        }
        It "Doesn't match year less than four digits" {
            NoMatchTest-Get-DatePartFromFolderName "999"
            NoMatchTest-Get-DatePartFromFolderName "11"
            NoMatchTest-Get-DatePartFromFolderName "1"
        }
        It "Doesn't match year less than 1" {
            NoMatchTest-Get-DatePartFromFolderName "0"
            NoMatchTest-Get-DatePartFromFolderName "-10"
            NoMatchTest-Get-DatePartFromFolderName "-999"
            NoMatchTest-Get-DatePartFromFolderName "-2015"
        }
        It "Doesn't match year over 9999" {
            NoMatchTest-Get-DatePartFromFolderName "10000"
            NoMatchTest-Get-DatePartFromFolderName "20015"
        }
    }
    Context "yyyyMM" {
        It "Matches yyyyMM at start of string" {
            Test-Get-DatePartFromFolderName "201601" 2016 1 31
            Test-Get-DatePartFromFolderName "201504 - Bar" 2015 4 30
            Test-Get-DatePartFromFolderName "201602 - Foo" 2016 2 29
            Test-Get-DatePartFromFolderName "201502 - Foo" 2015 2 28
        }
        It "Doesn't match yyyyMM not at start of string" {
            NoMatchTest-Get-DatePartFromFolderName " 201601"
            NoMatchTest-Get-DatePartFromFolderName " 201504 - Bar"
        }
        It "Doesn't match month less than 1" {
            NoMatchTest-Get-DatePartFromFolderName "201600"
            NoMatchTest-Get-DatePartFromFolderName "201500 - Bar"
        }
        It "Doesn't match month over 12" {
            NoMatchTest-Get-DatePartFromFolderName "201613"
        }
        It "Doesn't match 3 digit month" {
            NoMatchTest-Get-DatePartFromFolderName "2015121 - Bar"
        }
    }
    Context "yyyyMMdd" {
        It "Matches yyyyMMdd at start of string" {
            Test-Get-DatePartFromFolderName "20160203" 2016 2 3
            Test-Get-DatePartFromFolderName "20150407 - Bar" 2015 4 7
        }
        It "Matches yyyyMMdd on February leap-year days" {
            Test-Get-DatePartFromFolderName "20160229" 2016 2 29
            Test-Get-DatePartFromFolderName "20150228" 2015 2 28
            Test-Get-DatePartFromFolderName "20000229" 2000 2 29
        }
        It "Doesn't match yyyyMMdd not at start of string" {
            NoMatchTest-Get-DatePartFromFolderName " 20160203"
            NoMatchTest-Get-DatePartFromFolderName " 20150407 - Bar"
        }
        It "Doesn't match day less than 1" {
            NoMatchTest-Get-DatePartFromFolderName "20161200"
            NoMatchTest-Get-DatePartFromFolderName "20161500"
        }
        It "Doesn't match day over days in month" {
            NoMatchTest-Get-DatePartFromFolderName "20160230"
            NoMatchTest-Get-DatePartFromFolderName "20150229"
            NoMatchTest-Get-DatePartFromFolderName "20160332"
            NoMatchTest-Get-DatePartFromFolderName "20160150"
            NoMatchTest-Get-DatePartFromFolderName "21000229"
        }
    }
    Context "Unsupported dates" {
        It "Doesn't match MM/dd/yyyy" {
            NoMatchTest-Get-DatePartFromFolderName "03/03/2015"
        }
    }
}