<#

#>
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

. .\Mock-FileStream.ps1

if (-not ([System.Management.Automation.PSTypeName]'MockFileStream').Type) {
    Add-Type -TypeDefinition $mockFileStream
}

function TestGet-NextTerminator {
    Param(
        [string]$str,
        [string]$FieldTerminator,
        [string]$RowTerminator,
        [PSObject]$Expected
    )
    
    $fileStream = New-Object MockFileStream($str)
    
    $results = Get-NextTerminator $fileStream $FieldTerminator $RowTerminator
    
    $results.index | Should Be $Expected.index
    $results.cursor | Should Be $Expected.cursor
    $results.token | Should Be $Expected.token
    
    $fileStream.Close()
    $fileStream.Dispose()
}

Describe "Get-NextTerminator" {
    Context "Single Char Terminator" {
        $fieldTerminator = ","
        $rowTerminator = "`n"
        
        $fieldTermFirstStr = "abc,123`ndef,456"
        $rowTermFirstStr = "abc`n123,def,456"
        $eofTermFirstStr = "abc"
        
        $fieldTermFirstExpected = @{
            index = 3;
            cursor = 4;
            token = ",";
        }
        $rowTermFirstExpected = @{
            index = 3;
            cursor = 4;
            token = "`n";
        }
        $eofTermFirstExpected = @{
            index = 3;
            cursor = 3;
            token = $null;
        }
        
        It "Gets next field terminator first" {
            TestGet-NextTerminator $fieldTermFirstStr $fieldTerminator $rowTerminator $fieldTermFirstExpected
        }
        It "Gets next row terminator first" {
            TestGet-NextTerminator $rowTermFirstStr $fieldTerminator $rowTerminator $rowTermFirstExpected
        }
        It "Gets next file terminator first" {
            TestGet-NextTerminator $eofTermFirstStr $fieldTerminator $rowTerminator $eofTermFirstExpected
        }
    }
    Context "Multi Char Terminator" {
        $fieldTerminator = "><"
        $rowTerminator = "`r`n"
        
        $fieldTermFirstStr = "abc><123`r`ndef><456"
        $rowTermFirstStr = "abc`r`n123><def><456"
        
        $fieldTermFirstExpected = @{
            index = 3;
            cursor = 5;
            token = "><";
        }
        $rowTermFirstExpected = @{
            index = 3;
            cursor = 5;
            token = "`r`n";
        }
        
        It "Gets next field terminator first" {
            TestGet-NextTerminator $fieldTermFirstStr $fieldTerminator $rowTerminator $fieldTermFirstExpected
        }
        It "Gets next row terminator first" {
            TestGet-NextTerminator $rowTermFirstStr $fieldTerminator $rowTerminator $rowTermFirstExpected
        }
    }
}

