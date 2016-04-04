<#

#>

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

function TreesShouldMatch {
    Param(
        [PSObject]$Results,
        [PSObject]$Expected
    )
        
    $results.path | Should be "$($Expected.path)"
    $results.date | Should be $Expected.date
    
    if ($Results.subfolders -eq $null) {
        $Results.subfolders | Should Be $Expected.subfolders
    } elseif ($Results.subfolders.GetType() -eq [Object[]]) {
        for ($i = 0; $i -lt $Results.subfolders.Length; $i++) {
            TreesShouldMatch $Results.subfolders[$i] $Expected.subfolders[$i]
        }
    } elseif ($Results.subfolders.GetType() -eq [Hashtable]) {
        TreesShouldMatch $Results.subfolders $Expected.subfolders
    }
}

function Test-Get-DatedFolderTree {
    Param(
        [string]$RootPath,
        [PSObject]$Expected
    )
    
    $results = Get-DatedFolderTree $RootPath
    
    TreesShouldMatch $results $Expected
}

Describe "Get-DatedFolderTree" {
    $depth1DatePath = ".\Test\2014\20140301 - Foo"
    $depth1NoDatePath = ".\Test\Foo\Bar\Baz"
    $depth2DatePath = ".\Test\2014"
    $depth3SomeDatesPath = ".\Test\Foo\Bar"
    
    $depth1DateTree = @{
        path = Resolve-Path $depth1DatePath;
        date = New-Object DateTime(2014, 03, 01);
        subfolders = $null;
    }
    $depth1NoDateTree = @{
        path = Resolve-Path $depth1NoDatePath;
        date = $null;
        subfolders = $null;
    }
    $depth2DateTree = @{
        path = Resolve-Path $depth2DatePath;
        date = New-Object DateTime(2014, 12, 31);
        subfolders = @($depth1DateTree, @{
            path = Resolve-Path ".\Test\2014\20140602 - Bar";
            date = New-Object DateTime(2014, 06, 02);
            subfolders = $null;
        });
    }
    $depth3SomeDatesTree = @{
        path = Resolve-Path $depth3SomeDatesPath;
        date = $null;
        subfolders = @(@{
            path = Resolve-Path ".\Test\Foo\Bar\201601";
            date = New-Object DateTime(2016, 01, 31);
            subfolders = @(@{
                path = Resolve-Path ".\Test\Foo\Bar\201601\20160101";
                date = New-Object DateTime(2016, 01, 01);
                subfolders = $null
            }, @{
                path = Resolve-Path ".\Test\Foo\Bar\201601\20160115";
                date = New-Object DateTime(2016, 01, 15);
                subfolders = $null
            });
        }, @{
            path = Resolve-Path ".\Test\Foo\Bar\201602";
            date = New-Object DateTime(2016, 02, 29);
            subfolders = $null;
        }, @{
            path = Resolve-Path ".\Test\Foo\Bar\201603";
            date = New-Object DateTime(2016, 03, 31);
            subfolders = @(@{
                path = Resolve-Path ".\Test\Foo\Bar\201603\20160302";
                date = New-Object DateTime(2016, 03, 02);
                subfolders = $null;
            }, @{
                path = Resolve-Path ".\Test\Foo\Bar\201603\20160305";
                date = New-Object DateTime(2016, 03, 05);
                subfolders = $null;
            });
        }, $depth1NoDateTree);
    }
    
    $FullTree = @{
        path = ".\Test";
        date = $null;
        subfolders = @(@{
            path = ".\Test\2014";
            date = New-Object DateTime(2014, 12, 31);
            subfolders = @(@{
                path = ".\Test\2014\20140301 - Foo";
                date = New-Object DateTime(2014, 03, 01);
                subfolders = $null;
            }, @{
                path = ".\Test\2014\20140602 - Bar";
                date = New-Object DateTime(2014, 06, 02);
                subfolders = $null;
            });
        }, @{
            path = ".\Test\2015";
            date = New-Object DateTime(2015, 12, 31);
            subfolders = @(@{
                path = ".\Test\2015\20150101 - Foo";
                date = New-Object DateTime(2015, 01, 01);
                subfolders = $null;
            }, @{
                path = ".\Test\2015\20151202 - Bar";
                date = New-Object DateTime(2015, 12, 02);
                subfolders = $null;
            });
        }, @{
            path = ".\Test\2016";
            date = New-Object DateTime(2016, 12, 31);
            subfolders = @(@{
                path = ".\Test\2016\20160202 - Foo";
                date = New-Object DateTime(2016, 02, 02);
                subfolders = $null;
            }, @{
                path = ".\Test\2016\20160303 - Bar";
                date = New-Object DateTime(2016, 03, 03);
                subfolders = $null;
            })
        }, @{
            path = ".\Test\Foo";
            date = $null;
            subfolders = @(@{
                path = ".\Test\Foo\201501";
                date = New-Object DateTime(2015, 01, 31);
                subfolders = $null;
            }, @{
                path = ".\Test\Foo\201502";
                date = New-Object DateTime(2015, 02, 28);
                subfolders = $null;
            }, @{
                path = ".\Test\Foo\201503";
                date = New-Object DateTime(2015, 03, 31);
                subfolders = $null;
            }, @{
                path = ".\Test\Foo\Bar";
                date = New-Object DateTime(2016, 01, 31);
                subfolders = @(@{
                    path = ".\Test\Foo\Bar\201601";
                    date = New-Object DateTime(2016, 01, 01);
                    subfolders = @(@{
                        path = ".\Test\Foo\Bar\20160101";
                        date = New-Object DateTime(2016, 01, 01);
                        subfolders = $null
                    }, @{
                        path = ".\Test\Foo\Bar\20160115";
                        date = New-Object DateTime(2016, 01, 15);
                        subfolders = $null
                    });
                }, @{
                    path = ".\Test\Foo\Bar\201602";
                    date = New-Object DateTime(2016, 02, 29);
                    subfolders = $null;
                }, @{
                    path = ".\Test\Foo\Bar\201603";
                    date = New-Object DateTime(2016, 03, 31);
                    subfolders = @(@{
                        path = ".\Test\Foo\Bar\201603\20160302";
                        date = New-Object DateTime(2016, 03, 03);
                        subfolders = $null;
                    }, @{
                        path = ".\Test\Foo\Bar\201603\20160305";
                        date = New-Object DateTime(2016, 03, 05);
                        subfolders = $null;
                    });
                });
            });
        });
    }

    Context "Tree Depth = 1" {
        It "Has no subfolders" {
            Test-Get-DatedFolderTree $depth1DatePath $depth1DateTree
        }
        It "Has date on valid date prefix" {
            Test-Get-DatedFolderTree $depth1DatePath $depth1DateTree
        }
        It "Has null date on no date prefix" {
            Test-Get-DatedFolderTree $depth1NoDatePath $depth1NoDateTree
        }
    }
    Context "Tree Depth = 2" {
        It "Has subfolders" {
            Test-Get-DatedFolderTree $depth2DatePath $depth2DateTree
        }
    }
    Context "Tree Depth = 3" {
        It "Has subfolders" {
            Test-Get-DatedFolderTree $depth3SomeDatesPath $depth3SomeDatesTree
        }
    }
}