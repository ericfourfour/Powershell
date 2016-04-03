<#
.SYNOPSIS

Given a list of possible tokens, search the file-stream linearly until the
first one is discovered.

.PARAMETER FileStream

The filestream to search.

.PARAMETER Tokens

A list of tokens to search for.

.OUTPUTS

Returns a single PSObject with the following properties:
    index - the index of the terminator
    cursor - the position of the cursor
    token - the token that was discovered
    
.NOTES

This tokenizer only identifies the first instance of a token in the list. It
does not run accross the entire stream - it stops once one has been found. If
no token is found, $null is returned.
#>
function Get-FirstToken {
    Param(
        [System.IO.FileStream]$FileStream,
        [string[]]$Tokens
    )
    
    $tokenStrings = @{}
    $Tokens | ForEach-Object { $tokenStrings[$_] = "" }
    $tokenString = $null
    $cursor = 0
    $index = -1
    
    while (($byte = $FileStream.ReadByte()) -ge 0) {
        $c = [char]$byte
        $cursor++
        
        foreach ($token in $Tokens) {
            $tempTokenString = $tokenStrings[$token] + $c
            if ($token -like "$tempTokenString*") {
                $tokenStrings[$token] = $tempTokenString
            } else {
                $tokenStrings[$token] = ""
            }
            
            if ($tokenStrings[$token] -eq $token) {
                $tokenString = $tokenStrings[$token]
                break
            }
        }
        
        if ($tokenString -ne $null) {
            break
        }
    }
    
    $index = $cursor - $tokenString.Length
    return @{
        cursor = $cursor;
        index = $index;
        token = $tokenString;
    }
}

<#
.SYNOPSIS

Parse the token that starts at the beginning of the stream. If the stream does
not start with a token, then return $null as the token.

.PARAMETER FileStream

The filestream to search.

.PARAMETER Tokens

A list of tokens to search for.

.OUTPUTS

Returns a single PSObject with the following properties:
    index - the index of the token
    cursor - the position of the cursor
    token - the token that was discovered

.NOTES

This function can be used to verify whether a token is at a specific position
or not.
#>
function Get-ImmediateToken {
    Param(
        [System.IO.FileStream]$FileStream,
        [string[]]$Tokens
    )
    
    $tokenStrings = @{}
    $Tokens | ForEach-Object { $tokenStrings[$_] = "" }
    $tokenString = $null
    $cursor = 0
    $index = -1
    
    while (($byte = $FileStream.ReadByte()) -ge 0) {
        $c = [char]$byte
        $cursor++
        
        $matchingToken = $false
        foreach ($token in $Tokens) {
            $tempTokenString = $tokenStrings[$token] + $c
            if ($token -like "$tempTokenString*") {
                $tokenStrings[$token] = $tempTokenString
                $matchingToken = $true
            } else {
                $tokenStrings[$token] = ""
            }
            
            if ($tokenStrings[$token] -eq $token) {
                $tokenString = $tokenStrings[$token]
                break
            }
        }
        
        if (!$matchingToken) {
            return @{
                cursor = $cursor;
                index = $index;
                token = $tokenString;
            }
        }
        
        if ($tokenString -ne $null) {
            break
        }
    }
    
    $index = $cursor - $tokenString.Length
    return @{
        cursor = $cursor;
        index = $index;
        token = $tokenString;
    }
}

<#
.SYNOPSIS

Similar to the Get-FirstToken function except this one will ensure that the
token is not escaped.

.PARAMETER FileStream

The filestream to search.

.PARAMETER Tokens

A list of tokens to search for.

.PARAMETER Escape

The string that escapes the following token.

.OUTPUTS

Returns a single PSObject with the following properties:
    index - the index of the terminator
    cursor - the position of the cursor
    token - the token that was discovered
  
#>
function Get-FirstUnescapedToken {
    Param(
        [System.IO.FileStream]$FileStream,
        [string[]]$Tokens,
        [string]$Escape
    )
    
    
    $cursor = 0
    $index = 0
    while ($true) {
        $results = Get-FirstToken $FileStream (@(, $Escape) + $Tokens)
        $cursor += $results.cursor
        $index += $results.index
        
        if ($results.token -eq $Escape) {
            $nextResults = Get-ImmediateToken $FileStream $Tokens
            $cursor += $nextResults.cursor
            $index += $nextResults.index
            
            if ($nextResults.token -eq $null) {
                return @{
                    cursor = $cursor;
                    index = $index;
                    token = $results.token;
                }
            }
        } else {
            return $results
        }
    }
}