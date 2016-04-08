$depth1DatePath = ".\Test\2014\20140301 - Foo"
$depth1NoDatePath = ".\Test\Foo\Bar\Baz"
$depth2DatePath = ".\Test\2014"
$depth3SomeDatesPath = ".\Test\Foo\Bar"
$fullTestPath = ".\Test"

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
$fullTestTree = @{
    path = Resolve-Path $fullTestPath;
    date = $null;
    subfolders = @($depth2DateTree, @{
        path = Resolve-Path ".\Test\2015";
        date = New-Object DateTime(2015, 12, 31);
        subfolders = @(@{
            path = Resolve-Path ".\Test\2015\20150101 - Foo";
            date = New-Object DateTime(2015, 01, 01);
            subfolders = $null;
        }, @{
            path = Resolve-Path ".\Test\2015\20151202 - Bar";
            date = New-Object DateTime(2015, 12, 02);
            subfolders = $null;
        });
    }, @{
        path = Resolve-Path ".\Test\2016";
        date = New-Object DateTime(2016, 12, 31);
        subfolders = @(@{
            path = Resolve-Path ".\Test\2016\20160202 - Foo";
            date = New-Object DateTime(2016, 02, 02);
            subfolders = $null;
        }, @{
            path = Resolve-Path ".\Test\2016\20160303 - Bar";
            date = New-Object DateTime(2016, 03, 03);
            subfolders = $null;
        })
    }, @{
        path = Resolve-Path ".\Test\Foo";
        date = $null;
        subfolders = @(@{
            path = Resolve-Path ".\Test\Foo\201501";
            date = New-Object DateTime(2015, 01, 31);
            subfolders = $null;
        }, @{
            path = Resolve-Path ".\Test\Foo\201502";
            date = New-Object DateTime(2015, 02, 28);
            subfolders = $null;
        }, @{
            path = Resolve-Path ".\Test\Foo\201503";
            date = New-Object DateTime(2015, 03, 31);
            subfolders = $null;
        }, $depth3SomeDatesTree);
    });
}

$markedSixMonthDepth1DateTree = @{
    path = Resolve-Path $depth1DatePath;
    date = New-Object DateTime(2014, 03, 01);
    subfolders = $null;
    isOldEnough = $true
}
$markedSixMonthDepth1NoDateTree = @{
    path = Resolve-Path $depth1NoDatePath;
    date = $null;
    subfolders = $null;
    isOldEnough = $false;
}
$markedSixMonthDepth2DateTree = @{
    path = Resolve-Path $depth2DatePath;
    date = New-Object DateTime(2014, 12, 31);
    subfolders = @($depth1DateTree, @{
        path = Resolve-Path ".\Test\2014\20140602 - Bar";
        date = New-Object DateTime(2014, 06, 02);
        subfolders = $null;
        isOldEnough = $false;
    });
    isOldEnough = $true;
}
$markedSixMonthDepth3SomeDatesTree = @{
    path = Resolve-Path $depth3SomeDatesPath;
    date = $null;
    subfolders = @(@{
        path = Resolve-Path ".\Test\Foo\Bar\201601";
        date = New-Object DateTime(2016, 01, 31);
        subfolders = @(@{
            path = Resolve-Path ".\Test\Foo\Bar\201601\20160101";
            date = New-Object DateTime(2016, 01, 01);
            subfolders = $null;
            isOldEnough = $false;
        }, @{
            path = Resolve-Path ".\Test\Foo\Bar\201601\20160115";
            date = New-Object DateTime(2016, 01, 15);
            subfolders = $null;
            isOldEnough = $false;
        });
        isOldEnough = $false;
    }, @{
        path = Resolve-Path ".\Test\Foo\Bar\201602";
        date = New-Object DateTime(2016, 02, 29);
        subfolders = $null;
        isOldEnough = $false;
    }, @{
        path = Resolve-Path ".\Test\Foo\Bar\201603";
        date = New-Object DateTime(2016, 03, 31);
        subfolders = @(@{
            path = Resolve-Path ".\Test\Foo\Bar\201603\20160302";
            date = New-Object DateTime(2016, 03, 02);
            subfolders = $null;
            isOldEnough = $false;
        }, @{
            path = Resolve-Path ".\Test\Foo\Bar\201603\20160305";
            date = New-Object DateTime(2016, 03, 05);
            subfolders = $null;
            isOldEnough = $false;
        });
    }, $depth1NoDateTree);
    isOldEnough = $false;
}
$markedSixMonthFullTestTree = @{
    path = Resolve-Path $fullTestPath;
    date = $null;
    subfolders = @($depth2DateTree, @{
        path = Resolve-Path ".\Test\2015";
        date = New-Object DateTime(2015, 12, 31);
        subfolders = @(@{
            path = Resolve-Path ".\Test\2015\20150101 - Foo";
            date = New-Object DateTime(2015, 01, 01);
            subfolders = $null;
            isOldEnough = $true;
        }, @{
            path = Resolve-Path ".\Test\2015\20151202 - Bar";
            date = New-Object DateTime(2015, 12, 02);
            subfolders = $null;
            isOldEnough = $false;
        });
        isOldEnough = $false;
    }, @{
        path = Resolve-Path ".\Test\2016";
        date = New-Object DateTime(2016, 12, 31);
        subfolders = @(@{
            path = Resolve-Path ".\Test\2016\20160202 - Foo";
            date = New-Object DateTime(2016, 02, 02);
            subfolders = $null;
            isOldEnough = $false;
        }, @{
            path = Resolve-Path ".\Test\2016\20160303 - Bar";
            date = New-Object DateTime(2016, 03, 03);
            subfolders = $null;
            isOldEnough = $false;
        });
        isOldEnough = $false;
    }, @{
        path = Resolve-Path ".\Test\Foo";
        date = $null;
        subfolders = @(@{
            path = Resolve-Path ".\Test\Foo\201501";
            date = New-Object DateTime(2015, 01, 31);
            subfolders = $null;
            isOldEnough = $true;
        }, @{
            path = Resolve-Path ".\Test\Foo\201502";
            date = New-Object DateTime(2015, 02, 28);
            subfolders = $null;
            isOldEnough = $true;
        }, @{
            path = Resolve-Path ".\Test\Foo\201503";
            date = New-Object DateTime(2015, 03, 31);
            subfolders = $null;
            isOldEnough = $true;
        }, $depth3SomeDatesTree);
        isOldEnough = $false;
    });
    isOldEnough = $false;
}
