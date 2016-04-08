<#

#>

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "Filter-DatedFolderTreeByAge" {
    Context "Depth = 1; Date folder" {
        It "Is retained when old enough" {}
        It "Is not retained when not old enough" {}
    }
    Context "Depth = 1; Undated folder" {
        It "Is not retained" {}
    }
    Context "Depth = 2; Inner old enough" {
        It "Outer old enough: inner not retained, outer retained" {}
        It "Outer not old enough: inner retained, outer not retained" {}
    }
    Context "Depth = 2; Inner not old enough" {
        It "Outer not old enough: inner not retained, outer not retained" {}
    }
}