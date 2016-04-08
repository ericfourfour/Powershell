<#
.SYNOPSIS

Escapes a valid SQL query string so it can be used with the -Q argument in
sqlcmd.
#>
function Escape-QueryForSqlcmd {
    Param(
        [string]$Query
    )
    
    return $Query.Replace('"', '""')
}

function Escape-QueryForSqlString {
    Param(
        [string]$Query
    )
    
    return $Query.Replace("'", "''")
}