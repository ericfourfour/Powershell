. .\Simple-Tokenizer.ps1

<#
.SYNOPSIS

Move the cursor until it finds the end of the next terminator.

.PARAMETER FileStream

The filestream to search.

.PARAMETER FieldTerminator

The sequence of characters indicating the end of the field.

.PARAMETER RowTerminator

The sequence of characters indicating the end of the row as well as the end
of the last field in the row.

.OUTPUTS

Returns a single PSObject with the following properties:
    index - the index of the terminator
    cursor - the position of the cursor
    token - the terminator that was discovered
    
.NOTES

This tokenizer only identifies the field-terminator, row-terminator and
eof-terminator. It does not identify any other tokens that it may pass in its
search.
#>
function Get-NextTerminator {
    Param(
        [System.IO.FileStream]$FileStream,
        [string]$FieldTerminator,
        [string]$RowTerminator
    )
    
    return Get-NextToken $FileStream @($FieldTerminator, $RowTerminator, "")
}