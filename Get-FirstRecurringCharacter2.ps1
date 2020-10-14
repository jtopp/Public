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
    $Hash = @{}
    $Index = 0
    while ($Index -lt $Foo.Length) {
        $Char = $Foo.Substring($Index,1)
        if ($Hash[$Char] -eq 1) {
            $Answer = $Char
            $Index = $Foo.Length
        } else {
            $Hash[$Char] = 1
        }
        ++$Index
    }
    Write-Output $Answer
}