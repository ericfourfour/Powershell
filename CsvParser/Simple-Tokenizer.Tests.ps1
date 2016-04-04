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
        [string]$Str,
        [string[]]$Tokens,
        [PSObject]$Expected
    )
    
    $fileStream = New-Object MockFileStream($Str)
    
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

function eofExpectation {
    Param(
        [string]$Str
    )
    return @{index = $Str.Length; cursor = $Str.Length; token = $null}
}

Describe "Get-NextToken" {
    function noMatchExpectation {
        Param(
            [string]$Str
        )
        return @{index = -1; cursor = $Str.Length; token = $null}
    }
    function noMatchTest-Get-NextToken {
        Param(
            [string]$Str,
            [string[]]$Tokens
        )
        return Test-Get-NextToken $Str $Tokens (noMatchExpectation $Str)
    }
    function matchExpectation {
        Param(
            [string]$Token,
            [int]$Index
        )
        return @{index = $Index; cursor = $Index + $Token.Length; token = $Token}
    }
    function matchTest-Get-NextToken {
        Param(
            [string]$Str,
            [string[]]$Tokens,
            [string]$Token,
            [int]$Index
        )
        return Test-Get-NextToken $Str $Tokens (matchExpectation $Token $Index)
    }
    
    Context "No tokens" {
        It "Doesn't match" {
            Test-Get-NextToken "abc" ([string[]]@()) @{index = -1; cursor = 0; token = $null}
        }
    }
    Context "Null or empty token" {
        function eofTest-Get-NextToken {
            Param(
                [string]$Str,
                [string[]]$Tokens
            )
            Test-Get-NextToken $Str $Tokens (eofExpectation $Str)
        }
    
        It "Matches eof on empty string" {
            eofTest-Get-NextToken "abc" @(, "")
        }
        It "Matches eof on null cast to string" {
            eofTest-Get-NextToken "abc" ([string[]]@(, $null))
        }
    }
    Context "Single char tokens" {
        $singleCharTokens = @(',', '`n', '|')
        It "Matches when tokens are in stream" {
            matchTest-Get-NextToken "abc,123" $singleCharTokens "," 3
        }
        It "Doesn't match when tokens are not in stream" {
            noMatchTest-Get-NextToken "abc.123" $singleCharTokens
        }
    }
    Context "Multi char tokens" {
        $multiCharTokens = @("**", "`r`n", ", ")
        It "Matches when tokens are in stream" {
            matchTest-Get-NextToken "abc**123" $multiCharTokens "**" 3
        }
        It "Doesn't match when tokens are not in stream" {
            noMatchTest-Get-NextToken "abc..123" $multiCharTokens
        }
        It "Doesn't match partial tokens" {
            noMatchTest-Get-NextToken "abc*.123`r.def,`t" $multiCharTokens
        }
    }
    Context "Tokens inside tokens" {
        $tokensInsideTokens1 = @("a", "ab")
        $tokensInsideTokens2 = @("bc", "abc")
        $tokensInsideTokens3 = @("abc", "bc")
        It "Matches token that ends first" {
            matchTest-Get-NextToken "abc" $tokensInsideTokens1 "a" 0
        }
        It "Matches first token in list when ending at same time" {
            matchTest-Get-NextToken "abc" $tokensInsideTokens2 "bc" 1
            matchTest-Get-NextToken "abc" $tokensInsideTokens3 "abc" 0
        }
        It "Doesn't match when no tokens are in stream" {
            noMatchTest-Get-NextToken "def" $tokensInsideTokens1
        }
    }
}

Describe "Get-ImmediateToken" {
    Context "No tokens" {
        It "Returns no valid index" {
            Test-Get-ImmediateToken "abc" ([string[]]@()) @{index = -1; cursor = 0; token = $null}
        }
    }
    Context "Null or empty token" {
        It "Matches eof when empty string and cursor is at end of stream" {
            Test-Get-ImmediateToken "" @(, "") (eofExpectation "")
        }
        It "Matches eof when null cast to string and cursor is at end of stream" {
            Test-Get-ImmediateToken "" ([string[]]@(, $null)) (eofExpectation "")
        }
        It "Doesn't match when empty string and cursor is not at end of stream" {}
        It "Doesn't match when null cast to string and cursor is not at end of stream" {}
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