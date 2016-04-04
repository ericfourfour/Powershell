<#

#>

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

. .\Mock-FileStream.ps1

if (-not ([System.Management.Automation.PSTypeName]'MockFileStream').Type) {
    Add-Type -TypeDefinition $mockFileStream
}

function Test-Get-NextToken {
    Param(
        [string]$str,
        [string[]]$Tokens,
        [PSObject]$Expected
    )
    
    $fileStream = New-Object MockFileStream($str)
    
    $results = Get-NextToken $fileStream $Tokens
    
    $results.index | Should Be $Expected.index
    $results.cursor | Should Be $Expected.cursor
    $results.token | Should Be $Expected.token
    
    $fileStream.Close()
    $fileStream.Dispose()
}

function Test-Get-ImmediateToken {
    Param(
        [string]$str,
        [string[]]$Tokens,
        [PSObject]$Expected
    )
    
    $fileStream = New-Object MockFileStream($str)
    
    $results = Get-ImmediateToken $fileStream $Tokens
    
    $results.index | Should Be $Expected.index
    $results.cursor | Should Be $Expected.cursor
    $results.token | Should Be $Expected.token
    
    $fileStream.Close()
    $fileStream.Dispose()
}

function Test-Get-NextUnescapedToken {
    Param(
        [string]$str,
        [string[]]$Tokens,
        [string]$Escape,
        [PSObject]$Expected 
    )
    
    $fileStream = New-Object MockFileStream($str)
    
    $results = Get-NextUnescapedToken $fileStream $Tokens
    
    $results.index | Should Be $Expected.index
    $results.cursor | Should Be $Expected.cursor
    $results.token | Should Be $Expected.token
    
    $fileStream.Close()
    $fileStream.Dispose()
}

Describe "Get-NextToken" {
    Context "No tokens" {
        It "Returns no valid index" { }
    }
    Context "Null token" {
        It "Matches eof" { }
    }
    Context "Single char tokens" {
        It "Matches when tokens are in stream" { }
        It "Doesn't match when tokens are not in stream" { }
    }
    Context "Multi char tokens" {
        It "Matches when tokens are in stream" { }
        It "Doesn't match when tokens are not in stream" { }
        It "Doesn't match partial tokens" { }
    }
    Context "Tokens inside tokens" {
        It "Matches token that ends first" { }
        It "Matches first token in list when ending at same time" {}
        It "Doesn't match when no tokens are in stream" {}
    }
}

Describe "Get-ImmediateToken" {
    Context "No tokens" {
        It "Returns no valid index" { }
    }
    Context "Null token" {
        It "Matches when cursor at end of stream" { }
        It "Doesn't match when cursor is not at end of stream" {}
    }
    Context "Single char tokens" {
        It "Matches when tokens are at start of stream" {}
        It "Doesn't match when tokens are not at start of stream" {}
        It "Doesn't match when no tokens are in stream" {}
    }
    Context "Multi char tokens" {
        It "Matches when tokens are at start of stream" {}
        It "Doesn't match when tokens are not at start of stream" {}
        It "Doesn't match when no tokens are in stream" {}
    }
    Context "Tokens inside tokens" {
        It "Matches when tokens are at start of stream" {}
        It "Doesn't match when tokens are not at start of stream" {}
        It "Doesn't match when no tokens are in stream" {}
    }
}

Describe "Get-NextUnescapedToken" {
    Context "No tokens" {
        It "Returns no valid index" {}
    }
    Context "Null token" {
        It "Matches when eof not escaped" {}
        It "Doesn't match when eof escaped" {}
    }
    Context "Null escape" {
        It "Throws exception" {}
    }
    Context "Empty escape" {
        It "Throws exception" {}
    }
    Context "Single char tokens with single char escape" {
        It "Matches when unescaped token in stream" {}
        It "Doesn't match when all tokens escaped in stream" {}
        It "Doesn't match when no tokens in stream" {}
    }
    Context "Multi char tokens with single char escape" {
        It "Matches when unescaped token in stream" {}
        It "Doesn't match when all tokens escaped in stream" {}
        It "Doesn't match when no tokens in stream" {}
    }
    Context "Single char tokens with multi char escape" {
        It "Matches when unescaped token in stream" {}
        It "Doesn't match when all tokens escaped in stream" {}
        It "Doesn't match when no tokens in stream" {}
    }
    Context "Multi char tokens with multi char escape" {
        It "Matches when unescaped token in stream" {}
        It "Doesn't match when all tokens escaped in stream" {}
        It "Doesn't match when no tokens in stream" {}
    }
    Context "Tokens inside tokens with single char escape" {
        It "Matches unescaped tokens inside unescaped tokens" {}
        It "Doesn't match unescaped tokens inside escaped tokens" {}
        It "Doesn't match escaped tokens inside escaped tokens" {}
        It "Matches unescaped tokens containing escaped tokens" {}
        It "Doesn't match when all tokens escaped in stream" {}
        It "Doesn't match when no tokens in stream" {}
    }
    Context "Tokens inside tokens with multi char escape" {
        It "Matches unescaped tokens inside unescaped tokens" {}
        It "Doesn't match unescaped tokens inside escaped tokens" {}
        It "Doesn't match escaped tokens inside escaped tokens" {}
        It "Matches unescaped tokens containing escaped tokens" {}
        It "Doesn't match when all tokens escaped in stream" {}
        It "Doesn't match when no tokens in stream" {}
    }
}