<#

#>

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

. .\Mock-FileStream.ps1

if (-not ([System.Management.Automation.PSTypeName]'MockFileStream').Type) {
    Add-Type -TypeDefinition $mockFileStream
}

function TestGet-NextQualifierToken {
    Param(
        [string]$Str,
        [string]$Qualifier,
        [PSObject]$Expected
    )
    
    $fileStream = New-Object MockFileStream($Str)
    
    $results = Get-NextQualifierToken $fileStream $FieldTerminator $RowTerminator
    
    $results.index | Should Be $Expected.index
    $results.cursor | Should Be $Expected.cursor
    $results.token | Should Be $Expected.token
    
    $fileStream.Close()
    $fileStream.Dispose()
}

Describe "Get-NextQualifierToken" {
    Context "Single Char Qualifier" {
        $qualifier = '"'
        
        $qualEofStr = "abc$qualifier"
        $qualNotEofStr = "abc$qualifier123"
        $innerEscQualStr = "abc$qualifier$qualifier123$qualifier,def"
        $innerFieldTermStr = "abc,123$qualifier,def"
        $innerRowTermStr = "abc`n123$qualifier,def"
    
        $qualEofExpected = @{
            index = 3
            cursor = 4
            token = $qualifier
        }
        $qualNotEofExpected = @{
            index = 3
            cursor = 5
            token = $qualifier
        }
        $innerEscQualExpected = @{
            index = 8
            cursor = 10
            token = $qualifier
        }
        $innerFieldTermExpected = @{
            index = 7
            cursor = 9
            token = $qualifier
        }
        $innerRowTermExpected = @{
            index = 7
            cursor = 9
            token = $qualifier
        }
    
        It "Gets next qualifier followed by eof" {
            TestGet-NextQualifierToken $qualEofStr $qualifier $qualEofExpected
        }
        It "Gets next qualifier not followed by eof" {
            TestGet-NextQualifierToken $qualNotEofStr $qualifier $qualNotEofExpected
        }
        It "Gets next qualifier with inner escaped qualifier" {
            TestGet-NextQualifierToken $innerEscQualStr $qualifier $innerEscQualExpected
        }
        It "Gets next qualifier with inner field terminator" {
            TestGet-NextQualifierToken $innerFieldTermStr $qualifier $innerFieldTermExpected
        }
        It "Gets next qualifier with inner row terminator" {
            TestGet-NextQualifierToken $innerRowTermStr $qualifier $innerRowTermExpected
        }
    }
    Context "Multi Char Qualifier" {
        $qualifier = "**"
        
        $qualEofStr = "abc$qualifier"
        $qualNotEofStr = "abc$qualifier123"
        $innerEscQualStr = "abc$qualifier$qualifier123$qualifier,def"
        $innerFieldTermStr = "abc,123$qualifier,def"
        $innerRowTermStr = "abc`n123$qualifier,def"
        
        $qualEofExpected = @{
            index = 3
            cursor = 5
            token = $qualifier
        }
        $qualNotEofExpected = @{
            index = 3
            cursor = 6
            token = $qualifier
        }
        $innerEscQualExpected = @{
            index = 8
            cursor = 11
            token = $qualifier
        }
        $innerFieldTermExpected = @{
            index = 7
            cursor = 10
            token = $qualifier
        }
        $innerRowTermExpected = @{
            index = 7
            cursor = 10
            token = $qualifier
        }
        
        It "Gets next qualifier followed by eof" {
            TestGet-NextQualifierToken $qualEofStr $qualifier $qualEofExpected
        }
        It "Gets next qualifier not followed by eof" {
            TestGet-NextQualifierToken $qualNotEofStr $qualifier $qualNotEofExpected
        }
        It "Gets next qualifier with inner escaped qualifier" {
            TestGet-NextQualifierToken $innerEscQualStr $qualifier $innerEscQualExpected
        }
        It "Gets next qualifier with inner field terminator" {
            TestGet-NextQualifierToken $innerFieldTermStr $qualifier $innerFieldTermExpected
        }
        It "Gets next qualifier with inner row terminator" {
            TestGet-NextQualifierToken $innerRowTermStr $qualifier $innerRowTermExpected
        }
    }
}