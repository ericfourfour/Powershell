. .\Simple-Tokenizer.ps1

<#
.SYNOPSIS

Move the cursor until it finds the end of the next qualifier token.

.PARAMETER FileStream

The filestream to search.

.PARAMETER Qualifier

The sequence of characters indicating the end of a qualified field.

.OUTPUTS

Returns a single PSObject with the following properties:
    index - the index of the terminator
    cursor - the position of the cursor
    token - the terminator that was discovered
    
.NOTES

Qualifiers are strings that surround a field in order to included substrings
that may otherwise be identified as terminators. If a field is to contain
a qualifier it must be escaped by a preceding qualifier. So this function
doesn't just return the next qualifier string, it returns the next unescaped
qualifier string.
#>
function Get-NextQualifierToken {
    Param(
        [System.IO.FileStream]$FileStream,
        [string]$Qualifier
    )
    
    return Get-FirstUnescapedToken $FileStream @(, $Qualifier) $Qualifier
}