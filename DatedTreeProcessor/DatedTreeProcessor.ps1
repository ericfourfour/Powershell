<#
.SYNOPSIS

Recursively go through the folder tree to get the highest level dated folders.

.DESCRIPTION

The goal of this script is to identify the folders that are older than a
specific date so actions like archiving can be performed on them. If any
subfolders are older than the parent, they should be ignored and
encapsulated by the parent. If any subfolders are newer than the parent,
they should not be ignored and instead all subfolders and files on that
directory level should be returned and the parent ignored.

.OUTPUT

PSObjects are sent to the object stream as they are discovered. The contain
the following properties: path, date, isFolder
#>
function Get-FlatDatedTree {
    Param(
        [string]$Path
    )
}