$equalMinDateTree = @{
    subfolders = $null;
    date = New-Object DateTime(2015, 10, 05);
}
$equalMinDateTreeExpected = @{
    subfolders = $null;
    isOldEnough = $true;
}
$olderMinDateTree = @{
    subfolders = $null;
    date = New-Object DateTime(2015, 10, 04);
}
$olderMinDateTreeExpected = @{
    subfolders = $null;
    isOldEnough = $true;
}
$youngerMinDateTree = @{
    subfolders = $null;
    date = New-Object DateTime(2015, 10, 06);
}
$youngerMinDateTreeExpected = @{
    subfolders = $null;
    isOldEnough = $false;
}

$undatedTree = @{
    subfolders = $null;
    date = $null;
}
$undatedTreeExpected = @{
    subfolders = $null;
    isOldEnough = $false;
}

$innerOlderOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 04);
    };
}
$innerOlderOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 04);
    };
}
$innerOlderOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 04);
    };
}
$innerOlderOuterUndated = @{
    date = $null;
    subfolders = @{
        date = New-Object DateTime(2015, 10, 04);
    };
}

$innerOlderOuterOlderExpected = @{
    isOldEnough = $true;
    subfolders = @{
       isOldEnough = $true; 
    };
}
$innerOlderOuterEqualExpected = @{
    isOldEnough = $true;
    subfolders = @{
       isOldEnough = $true; 
    };
}
$innerOlderOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @{
       isOldEnough = $true; 
    };
}
$innerOlderOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @{
       isOldEnough = $true; 
    };
}

$innerEqualOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 05);
    };
}
$innerEqualOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 05);
    };
}
$innerEqualOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 05);
    };
}
$innerEqualOuterUndated = @{
    date = $null;
    subfolders = @{
        date = New-Object DateTime(2015, 10, 05);
    };
}

$innerEqualOuterOlderExpected = @{
    isOldEnough = $true;
    subfolders = @{
       isOldEnough = $true; 
    };
}
$innerEqualOuterEqualExpected = @{
    isOldEnough = $true;
    subfolders = @{
       isOldEnough = $true; 
    };
}
$innerEqualOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @{
       isOldEnough = $true; 
    };
}
$innerEqualOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @{
       isOldEnough = $true; 
    };
}

$innerYoungerOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 06);
    };
}
$innerYoungerOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 06);
    };
}
$innerYoungerOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 06);
    };
}
$innerYoungerOuterUndated = @{
    date = $null;
    subfolders = @{
        date = New-Object DateTime(2015, 10, 06);
    };
}

$innerYoungerOuterOlderExpected = @{
    isOldEnough = $false;
    subfolders = @{
       isOldEnough = $false; 
    };
}
$innerYoungerOuterEqualExpected = @{
    isOldEnough = $false;
    subfolders = @{
       isOldEnough = $false; 
    };
}
$innerYoungerOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @{
       isOldEnough = $false; 
    };
}
$innerYoungerOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @{
       isOldEnough = $false; 
    };
}

$innerUndatedOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @{
        date = $null;
    };
}
$innerUndatedOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @{
        date = $null;
    };
}
$innerUndatedOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @{
        date = $null;
    };
}
$innerUndatedOuterUndated = @{
    date = $null;
    subfolders = @{
        date = $null;
    };
}

$innerUndatedOuterOlderExpected = @{
    isOldEnough = $true;
    subfolders = @{
       isOldEnough = $true; 
    };
}
$innerUndatedOuterEqualExpected = @{
    isOldEnough = $true;
    subfolders = @{
       isOldEnough = $true; 
    };
}
$innerUndatedOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @{
       isOldEnough = $false; 
    };
}
$innerUndatedOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @{
       isOldEnough = $false; 
    };
}

$innersOlderOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 04);
    }, @{
        date = New-Object DateTime(2015, 10, 03);
    });
}
$innersOlderOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 04);
    }, @{
        date = New-Object DateTime(2015, 10, 03);
    });
}
$innersOlderOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 04);
    }, @{
        date = New-Object DateTime(2015, 10, 03);
    });
}
$innersOlderOuterUndated = @{
    date = $null;
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 04);
    }, @{
        date = New-Object DateTime(2015, 10, 03);
    });
}

$innersOlderOuterOlderExpected = @{
    isOldEnough = $true;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $true; 
    });
}
$innersOlderOuterEqualExpected = @{
    isOldEnough = $true;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $true; 
    });
}
$innersOlderOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $true; 
    });
}
$innersOlderOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $true; 
    });
}

$innersEqualOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 05);
    }, @{
        date = New-Object DateTime(2015, 10, 05);
    });
}
$innersEqualOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 05);
    }, @{
        date = New-Object DateTime(2015, 10, 05);
    });
}
$innersEqualOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 05);
    }, @{
        date = New-Object DateTime(2015, 10, 05);
    });
}
$innersEqualOuterUndated = @{
    date = $null;
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 05);
    }, @{
        date = New-Object DateTime(2015, 10, 05);
    });
}

$innersEqualOuterOlderExpected = @{
    isOldEnough = $true;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $true; 
    });
}
$innersEqualOuterEqualExpected = @{
    isOldEnough = $true;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $true; 
    });
}
$innersEqualOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $true; 
    });
}
$innersEqualOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $true; 
    });
}

$innersYoungerOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 06);
    }, @{
        date = New-Object DateTime(2015, 10, 06);
    });
}
$innersYoungerOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 06);
    }, @{
        date = New-Object DateTime(2015, 10, 06);
    });
}
$innersYoungerOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 06);
    }, @{
        date = New-Object DateTime(2015, 10, 06);
    });
}
$innersYoungerOuterUndated = @{
    date = $null;
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 06);
    }, @{
        date = New-Object DateTime(2015, 10, 06);
    });
}

$innersYoungerOuterOlderExpected = @{
    isOldEnough = $false;
    subfolders = @(@{
       isOldEnough = $false; 
    }, @{
       isOldEnough = $false; 
    });
}
$innersYoungerOuterEqualExpected = @{
    isOldEnough = $false;
    subfolders = @(@{
       isOldEnough = $false; 
    }, @{
       isOldEnough = $false; 
    });
}
$innersYoungerOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @(@{
       isOldEnough = $false; 
    }, @{
       isOldEnough = $false; 
    });
}
$innersYoungerOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @(@{
       isOldEnough = $false; 
    }, @{
       isOldEnough = $false; 
    });
}

$innersUndatedOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @(@{
        date = $null;
    }, @{
        date = $null;
    });
}
$innersUndatedOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @(@{
        date = $null;
    }, @{
        date = $null;
    });
}
$innersUndatedOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @(@{
        date = $null;
    }, @{
        date = $null;
    });
}
$innersUndatedOuterUndated = @{
    date = $null;
    subfolders = @(@{
        date = $null;
    }, @{
        date = $null;
    });
}

$innersUndatedOuterOlderExpected = @{
    isOldEnough = $true;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $true; 
    });
}
$innersUndatedOuterEqualExpected = @{
    isOldEnough = $true;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $true; 
    });
}
$innersUndatedOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @(@{
       isOldEnough = $false; 
    }, @{
       isOldEnough = $false; 
    });
}
$innersUndatedOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @(@{
       isOldEnough = $false; 
    }, @{
       isOldEnough = $false; 
    });
}

$innersOlderAndEqualOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 04);
    }, @{
        date = New-Object DateTime(2015, 10, 05);
    });
}
$innersOlderAndEqualOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 04);
    }, @{
        date = New-Object DateTime(2015, 10, 05);
    });
}
$innersOlderAndEqualOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 04);
    }, @{
        date = New-Object DateTime(2015, 10, 05);
    });
}
$innersOlderAndEqualOuterUndated = @{
    date = $null;
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 04);
    }, @{
        date = New-Object DateTime(2015, 10, 05);
    });
}

$innersOlderAndEqualOuterOlderExpected = @{
    isOldEnough = $true;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $true; 
    });
}
$innersOlderAndEqualOuterEqualExpected = @{
    isOldEnough = $true;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $true; 
    });
}
$innersOlderAndEqualOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $true; 
    });
}
$innersOlderAndEqualOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $true; 
    });
}

$innersOlderAndYoungerOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 04);
    }, @{
        date = New-Object DateTime(2015, 10, 06);
    });
}
$innersOlderAndYoungerOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 04);
    }, @{
        date = New-Object DateTime(2015, 10, 06);
    });
}
$innersOlderAndYoungerOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 04);
    }, @{
        date = New-Object DateTime(2015, 10, 06);
    });
}
$innersOlderAndYoungerOuterUndated = @{
    date = $null;
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 04);
    }, @{
        date = New-Object DateTime(2015, 10, 06);
    });
}

$innersOlderAndYoungerOuterOlderExpected = @{
    isOldEnough = $false;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $false; 
    });
}
$innersOlderAndYoungerOuterEqualExpected = @{
    isOldEnough = $false;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $false; 
    });
}
$innersOlderAndYoungerOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $false; 
    });
}
$innersOlderAndYoungerOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $false; 
    });
}

$innersOlderAndUndatedOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 04);
    }, @{
        date = $null;
    });
}
$innersOlderAndUndatedOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 04);
    }, @{
        date = $null;
    });
}
$innersOlderAndUndatedOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 04);
    }, @{
        date = $null;
    });
}
$innersOlderAndUndatedOuterUndated = @{
    date = $null;
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 04);
    }, @{
        date = $null;
    });
}

$innersOlderAndUndatedOuterOlderExpected = @{
    isOldEnough = $true;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $true; 
    });
}
$innersOlderAndUndatedOuterEqualExpected = @{
    isOldEnough = $true;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $true; 
    });
}
$innersOlderAndUndatedOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $false; 
    });
}
$innersOlderAndUndatedOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $false; 
    });
}

$innersEqualAndYoungerOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 05);
    }, @{
        date = New-Object DateTime(2015, 10, 06);
    });
}
$innersEqualAndYoungerOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 05);
    }, @{
        date = New-Object DateTime(2015, 10, 06);
    });
}
$innersEqualAndYoungerOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 05);
    }, @{
        date = New-Object DateTime(2015, 10, 06);
    });
}
$innersEqualAndYoungerOuterUndated = @{
    date = $null;
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 05);
    }, @{
        date = New-Object DateTime(2015, 10, 06);
    });
}

$innersEqualAndYoungerOuterOlderExpected = @{
    isOldEnough = $false;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $false; 
    });
}
$innersEqualAndYoungerOuterEqualExpected = @{
    isOldEnough = $false;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $false; 
    });
}
$innersEqualAndYoungerOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $false; 
    });
}
$innersEqualAndYoungerOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $false; 
    });
}

$innersEqualAndUndatedOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 05);
    }, @{
        date = $null;
    });
}
$innersEqualAndUndatedOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 05);
    }, @{
        date = $null;
    });
}
$innersEqualAndUndatedOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 05);
    }, @{
        date = $null;
    });
}
$innersEqualAndUndatedOuterUndated = @{
    date = $null;
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 05);
    }, @{
        date = $null;
    });
}

$innersEqualAndUndatedOuterOlderExpected = @{
    isOldEnough = $true;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $true; 
    });
}
$innersEqualAndUndatedOuterEqualExpected = @{
    isOldEnough = $true;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $true; 
    });
}
$innersEqualAndUndatedOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $false; 
    });
}
$innersEqualAndUndatedOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @(@{
       isOldEnough = $true; 
    }, @{
       isOldEnough = $false; 
    });
}

$innersYoungerAndUndatedOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 06);
    }, @{
        date = $null;
    });
}
$innersYoungerAndUndatedOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 06);
    }, @{
        date = $null;
    });
}
$innersYoungerAndUndatedOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 06);
    }, @{
        date = $null;
    });
}
$innersYoungerAndUndatedOuterUndated = @{
    date = $null;
    subfolders = @(@{
        date = New-Object DateTime(2015, 10, 06);
    }, @{
        date = $null;
    });
}

$innersYoungerAndUndatedOuterOlderExpected = @{
    isOldEnough = $false;
    subfolders = @(@{
       isOldEnough = $false; 
    }, @{
       isOldEnough = $true; 
    });
}
$innersYoungerAndUndatedOuterEqualExpected = @{
    isOldEnough = $false;
    subfolders = @(@{
       isOldEnough = $false; 
    }, @{
       isOldEnough = $true; 
    });
}
$innersYoungerAndUndatedOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @(@{
       isOldEnough = $false; 
    }, @{
       isOldEnough = $false; 
    });
}
$innersYoungerAndUndatedOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @(@{
       isOldEnough = $false; 
    }, @{
       isOldEnough = $false; 
    });
}

$innerOlderMiddleOlderOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 04);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 04);
        };  
    };
}
$innerOlderMiddleOlderOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 04);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 04);
        };  
    };
}
$innerOlderMiddleOlderOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 04);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 04);
        };  
    };
}
$innerOlderMiddleOlderOuterUndated = @{
    date = $null
    subfolders = @{
        date = New-Object DateTime(2015, 10, 04);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 04);
        };  
    };
}

$innerOlderMiddleEqualOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 05);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 04);
        };  
    };
}
$innerOlderMiddleEqualOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 05);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 04);
        };  
    };
}
$innerOlderMiddleEqualOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 05);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 04);
        };  
    };
}
$innerOlderMiddleEqualOuterUndated = @{
    date = $null
    subfolders = @{
        date = New-Object DateTime(2015, 10, 05);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 04);
        };  
    };
}

$innerOlderMiddleYoungerOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 06);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 04);
        };  
    };
}
$innerOlderMiddleYoungerOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 06);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 04);
        };  
    };
}
$innerOlderMiddleYoungerOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 06);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 04);
        };  
    };
}
$innerOlderMiddleYoungerOuterUndated = @{
    date = $null
    subfolders = @{
        date = New-Object DateTime(2015, 10, 06);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 04);
        };  
    };
}

$innerOlderMiddleUndatedOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @{
        date = $null;
        subfolders = @{
            date = New-Object DateTime(2015, 10, 04);
        };  
    };
}
$innerOlderMiddleUndatedOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @{
        date = $null;
        subfolders = @{
            date = New-Object DateTime(2015, 10, 04);
        };  
    };
}
$innerOlderMiddleUndatedOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @{
        date = $null;
        subfolders = @{
            date = New-Object DateTime(2015, 10, 04);
        };  
    };
}
$innerOlderMiddleUndatedOuterUndated = @{
    date = $null
    subfolders = @{
        date = $null;
        subfolders = @{
            date = New-Object DateTime(2015, 10, 04);
        };  
    };
}

$innerOlderMiddleOlderOuterOlderExpected = @{
    isOldEnough = $true;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerOlderMiddleOlderOuterEqualExpected = @{
    isOldEnough = $true;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerOlderMiddleOlderOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerOlderMiddleOlderOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}

$innerOlderMiddleEqualOuterOlderExpected = @{
    isOldEnough = $true;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerOlderMiddleEqualOuterEqualExpected = @{
    isOldEnough = $true;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerOlderMiddleEqualOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerOlderMiddleEqualOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}

$innerOlderMiddleYoungerOuterOlderExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerOlderMiddleYoungerOuterEqualExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerOlderMiddleYoungerOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerOlderMiddleYoungerOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}

$innerOlderMiddleUndatedOuterOlderExpected = @{
    isOldEnough = $true;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerOlderMiddleUndatedOuterEqualExpected = @{
    isOldEnough = $true;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerOlderMiddleUndatedOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerOlderMiddleUndatedOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}

$innerEqualMiddleOlderOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 04);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 05);
        };  
    };
}
$innerEqualMiddleOlderOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 04);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 05);
        };  
    };
}
$innerEqualMiddleOlderOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 04);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 05);
        };  
    };
}
$innerEqualMiddleOlderOuterUndated = @{
    date = $null
    subfolders = @{
        date = New-Object DateTime(2015, 10, 04);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 05);
        };  
    };
}

$innerEqualMiddleEqualOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 05);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 05);
        };  
    };
}
$innerEqualMiddleEqualOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 05);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 05);
        };  
    };
}
$innerEqualMiddleEqualOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 05);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 05);
        };  
    };
}
$innerEqualMiddleEqualOuterUndated = @{
    date = $null
    subfolders = @{
        date = New-Object DateTime(2015, 10, 05);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 05);
        };  
    };
}

$innerEqualMiddleYoungerOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 06);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 05);
        };  
    };
}
$innerEqualMiddleYoungerOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 06);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 05);
        };  
    };
}
$innerEqualMiddleYoungerOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 06);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 05);
        };  
    };
}
$innerEqualMiddleYoungerOuterUndated = @{
    date = $null
    subfolders = @{
        date = New-Object DateTime(2015, 10, 06);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 05);
        };  
    };
}

$innerEqualMiddleUndatedOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @{
        date = $null;
        subfolders = @{
            date = New-Object DateTime(2015, 10, 05);
        };  
    };
}
$innerEqualMiddleUndatedOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @{
        date = $null;
        subfolders = @{
            date = New-Object DateTime(2015, 10, 05);
        };  
    };
}
$innerEqualMiddleUndatedOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @{
        date = $null;
        subfolders = @{
            date = New-Object DateTime(2015, 10, 05);
        };  
    };
}
$innerEqualMiddleUndatedOuterUndated = @{
    date = $null
    subfolders = @{
        date = $null;
        subfolders = @{
            date = New-Object DateTime(2015, 10, 05);
        };  
    };
}

$innerEqualMiddleOlderOuterOlderExpected = @{
    isOldEnough = $true;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerEqualMiddleOlderOuterEqualExpected = @{
    isOldEnough = $true;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerEqualMiddleOlderOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerEqualMiddleOlderOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}

$innerEqualMiddleEqualOuterOlderExpected = @{
    isOldEnough = $true;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerEqualMiddleEqualOuterEqualExpected = @{
    isOldEnough = $true;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerEqualMiddleEqualOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerEqualMiddleEqualOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}

$innerEqualMiddleYoungerOuterOlderExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerEqualMiddleYoungerOuterEqualExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerEqualMiddleYoungerOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerEqualMiddleYoungerOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}

$innerEqualMiddleUndatedOuterOlderExpected = @{
    isOldEnough = $true;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerEqualMiddleUndatedOuterEqualExpected = @{
    isOldEnough = $true;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerEqualMiddleUndatedOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerEqualMiddleUndatedOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}

$innerYoungerMiddleOlderOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 04);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 06);
        };  
    };
}
$innerYoungerMiddleOlderOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 04);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 06);
        };  
    };
}
$innerYoungerMiddleOlderOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 04);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 06);
        };  
    };
}
$innerYoungerMiddleOlderOuterUndated = @{
    date = $null
    subfolders = @{
        date = New-Object DateTime(2015, 10, 04);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 06);
        };  
    };
}

$innerYoungerMiddleEqualOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 05);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 06);
        };  
    };
}
$innerYoungerMiddleEqualOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 05);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 06);
        };  
    };
}
$innerYoungerMiddleEqualOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 05);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 06);
        };  
    };
}
$innerYoungerMiddleEqualOuterUndated = @{
    date = $null
    subfolders = @{
        date = New-Object DateTime(2015, 10, 05);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 06);
        };  
    };
}

$innerYoungerMiddleYoungerOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 06);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 06);
        };  
    };
}
$innerYoungerMiddleYoungerOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 06);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 06);
        };  
    };
}
$innerYoungerMiddleYoungerOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 06);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 06);
        };  
    };
}
$innerYoungerMiddleYoungerOuterUndated = @{
    date = $null
    subfolders = @{
        date = New-Object DateTime(2015, 10, 06);
        subfolders = @{
            date = New-Object DateTime(2015, 10, 06);
        };  
    };
}

$innerYoungerMiddleUndatedOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @{
        date = $null;
        subfolders = @{
            date = New-Object DateTime(2015, 10, 06);
        };  
    };
}
$innerYoungerMiddleUndatedOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @{
        date = $null;
        subfolders = @{
            date = New-Object DateTime(2015, 10, 06);
        };  
    };
}
$innerYoungerMiddleUndatedOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @{
        date = $null;
        subfolders = @{
            date = New-Object DateTime(2015, 10, 06);
        };  
    };
}
$innerYoungerMiddleUndatedOuterUndated = @{
    date = $null
    subfolders = @{
        date = $null;
        subfolders = @{
            date = New-Object DateTime(2015, 10, 06);
        };  
    };
}

$innerYoungerMiddleOlderOuterOlderExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $false;
        };  
    };
}
$innerYoungerMiddleOlderOuterEqualExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $false;
        };  
    };
}
$innerYoungerMiddleOlderOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $false;
        };  
    };
}
$innerYoungerMiddleOlderOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $false;
        };  
    };
}

$innerYoungerMiddleEqualOuterOlderExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $false;
        };  
    };
}
$innerYoungerMiddleEqualOuterEqualExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $false;
        };  
    };
}
$innerYoungerMiddleEqualOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $false;
        };  
    };
}
$innerYoungerMiddleEqualOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $false;
        };  
    };
}

$innerYoungerMiddleYoungerOuterOlderExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $false;
        };  
    };
}
$innerYoungerMiddleYoungerOuterEqualExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $false;
        };  
    };
}
$innerYoungerMiddleYoungerOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $false;
        };  
    };
}
$innerYoungerMiddleYoungerOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $false;
        };  
    };
}

$innerYoungerMiddleUndatedOuterOlderExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $false;
        };  
    };
}
$innerYoungerMiddleUndatedOuterEqualExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $false;
        };  
    };
}
$innerYoungerMiddleUndatedOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $false;
        };  
    };
}
$innerYoungerMiddleUndatedOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $false;
        };  
    };
}

$innerUndatedMiddleOlderOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 04);
        subfolders = @{
            date = $null;
        };  
    };
}
$innerUndatedMiddleOlderOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 04);
        subfolders = @{
            date = $null;
        };  
    };
}
$innerUndatedMiddleOlderOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 04);
        subfolders = @{
            date = $null;
        };  
    };
}
$innerUndatedMiddleOlderOuterUndated = @{
    date = $null
    subfolders = @{
        date = New-Object DateTime(2015, 10, 04);
        subfolders = @{
            date = $null;
        };  
    };
}

$innerUndatedMiddleEqualOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 05);
        subfolders = @{
            date = $null;
        };  
    };
}
$innerUndatedMiddleEqualOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 05);
        subfolders = @{
            date = $null;
        };  
    };
}
$innerUndatedMiddleEqualOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 05);
        subfolders = @{
            date = $null;
        };  
    };
}
$innerUndatedMiddleEqualOuterUndated = @{
    date = $null
    subfolders = @{
        date = New-Object DateTime(2015, 10, 05);
        subfolders = @{
            date = $null;
        };  
    };
}

$innerUndatedMiddleYoungerOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 06);
        subfolders = @{
            date = $null;
        };  
    };
}
$innerUndatedMiddleYoungerOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 06);
        subfolders = @{
            date = $null;
        };  
    };
}
$innerUndatedMiddleYoungerOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @{
        date = New-Object DateTime(2015, 10, 06);
        subfolders = @{
            date = $null;
        };  
    };
}
$innerUndatedMiddleYoungerOuterUndated = @{
    date = $null
    subfolders = @{
        date = New-Object DateTime(2015, 10, 06);
        subfolders = @{
            date = $null;
        };  
    };
}

$innerUndatedMiddleUndatedOuterOlder = @{
    date = New-Object DateTime(2015, 10, 04);
    subfolders = @{
        date = $null;
        subfolders = @{
            date = $null;
        };  
    };
}
$innerUndatedMiddleUndatedOuterEqual = @{
    date = New-Object DateTime(2015, 10, 05);
    subfolders = @{
        date = $null;
        subfolders = @{
            date = $null;
        };  
    };
}
$innerUndatedMiddleUndatedOuterYounger = @{
    date = New-Object DateTime(2015, 10, 06);
    subfolders = @{
        date = $null;
        subfolders = @{
            date = $null;
        };  
    };
}
$innerUndatedMiddleUndatedOuterUndated = @{
    date = $null
    subfolders = @{
        date = $null;
        subfolders = @{
            date = $null;
        };  
    };
}

$innerUndatedMiddleOlderOuterOlderExpected = @{
    isOldEnough = $true;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerUndatedMiddleOlderOuterEqualExpected = @{
    isOldEnough = $true;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerUndatedMiddleOlderOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerUndatedMiddleOlderOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}

$innerUndatedMiddleEqualOuterOlderExpected = @{
    isOldEnough = $true;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerUndatedMiddleEqualOuterEqualExpected = @{
    isOldEnough = $true;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerUndatedMiddleEqualOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerUndatedMiddleEqualOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}

$innerUndatedMiddleYoungerOuterOlderExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $false;
        };  
    };
}
$innerUndatedMiddleYoungerOuterEqualExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $false;
        };  
    };
}
$innerUndatedMiddleYoungerOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $false;
        };  
    };
}
$innerUndatedMiddleYoungerOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $false;
        };  
    };
}

$innerUndatedMiddleUndatedOuterOlderExpected = @{
    isOldEnough = $true;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerUndatedMiddleUndatedOuterEqualExpected = @{
    isOldEnough = $true;
    subfolders = @{
        isOldEnough = $true;
        subfolders = @{
            isOldEnough = $true;
        };  
    };
}
$innerUndatedMiddleUndatedOuterYoungerExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $false;
        };  
    };
}
$innerUndatedMiddleUndatedOuterUndatedExpected = @{
    isOldEnough = $false;
    subfolders = @{
        isOldEnough = $false;
        subfolders = @{
            isOldEnough = $false;
        };  
    };
}




