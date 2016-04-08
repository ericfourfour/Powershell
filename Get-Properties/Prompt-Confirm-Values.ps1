. .\Prompt-Values.ps1
. .\Prompt-Choice.ps1

function Prompt-Confirm-Values {
    <#
    
    #>
    Param(
        [hashtable]$ProprtyConfiguration
    )
    
    $values = @{}
    $isConfirmed = $false
    while (!$isConfirmed) {
        $values = Prompt-Values $ProprtyConfiguration
        
        Write-Host ""
        Write-HostResource $strings.Prompts.PropConfirmAll
        Write-Host ""
        $values.GetEnumerator() | foreach {Write-Host "$($_.Key) = $($_.Value)"}
        Write-Host ""
        
        $input = Prompt-Choice $strings.Prompts.PropConfirmCorrect.Value $strings.Prompts.PropInvalidChoice.Value @("y", "n")
        
        $isConfirmed = $input -eq "y"
    }
    return $values
}