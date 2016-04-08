function Prompt-Choice {
    <#
    
    #>
    Param(
        [string]$PromptMessage,
        [string]$InvalidMessage,
        [string[]]$Choices
    )
    
    $maxLength = ($Choices | Measure-Object -Maximum -Property Length).Maximum
    while ($true) {
        $input = Read-Host "$PromptMessage [$($Choices -Join '/')]"
        
        $input = $input.Substring(0, [math]::min($input.Length, $maxLength))
        
        if ($Choices -Contains ($input)) {
            return $input
        } else {
            Write-Host $InvalidMessage
        }
    }
}