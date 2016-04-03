<#
.SYNOPSIS

A collection functions used to tokenize the CSV file.

.DESCRIPTION

A CSV file consists rows, fields, qualifiers and terminators organized in a
way that represents tabular data. The following functions are used to parse
the input stream and determine where the rows, fields, and terminators are
located. This location and identification process is known as the tokenization
process.

When a tokenizer function is run, it returns a PSObject that identifies the
index of the token, where it left the stream cursor, the element it found
(if not implicit), and any sub tokens parsed along the way.

For example, a row tokenizer will move the cursor parsing any tokens until it
reaches the end of the current row.

A field tokenizer, will move the cursor until parsing any tokens until it
reaches the end of the end of the current field.

A qualifier tokenizer, will move the cursor until it finds the end of the next
qualifier.

A terminator tokenizer, will move the cursor until it finds the end of the
next terminator.
#>