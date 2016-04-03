<#
.SYNOPSIS

A CSV parser for powershell with slightly different functionality than the
Import-Csv cmdlet.

.DESCRIPTION

In Import-Csv, the number of columns is determined first and if there are any
extra fields in a row they are squeezed into the last column. This can prevent
you from being able to detect extra delimiters or invalid qualifiers when you
pre-validate your data.

What this parser does differently, is it returns the whole list of fields to
the object stream without squeezing multiple fields into a single column. This
allows you to pre-validate your data for too few or too many delimiters, and
invalid qualifiers. Neither of these can be easily detected using Import-Csv
or .NET bulk import.

Another option for Windows users is to use one of the many custom C# parsers,
like the one available at
http://www.codeproject.com/Articles/17840/Simple-CSV-Parser-Reader-Function-Written-in-C

However, some users may find value in having a Powershell CSV parser.
#>
