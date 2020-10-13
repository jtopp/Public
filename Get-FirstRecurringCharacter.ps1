function Get-FirstRecurringCharacter {
    <#
        .SYNOPSIS
        Returns the first recurring character of the input string
        .DESCRIPTION
        Returns the first recurring character of the input string
        .PARAMETER Foo
        A string value
        .OUTPUTS
        A single character (if a recurring one is found) or a null value
        .EXAMPLE
        Get-FirstRecurringCharacter abcdedcba
        Returns 'd'
        .EXAMPLE
        Get-FirstRecurringCharacter abcdefghij
        Returns $null
    #>
     
    [CmdletBinding()]
    param ([Parameter(Mandatory)] [string]$Foo)

    $Answer = $null
    $Index = 0
    $LoopEnd = $Foo.Length
    while ($Index -lt $LoopEnd) {
        $Char = $Foo.Substring($Index,1)
        $Another = $Foo.Substring($Index + 1).IndexOf($Char)
        if ($Another -gt -1) {
            $IndexOfAnother = $Another + $Index + 1
            if ($IndexOfAnother -lt $LoopEnd) {
                $LoopEnd = $IndexOfAnother
                $Answer = $Char
            }
        } else {
            $IndexOfAnother = 0
        }
        ++$Index
    }
    Write-Output $Answer
}