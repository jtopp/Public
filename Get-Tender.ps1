# Write a function named tender (or something) that takes an amount of change, and 
# returns the minimum number of coins required to make change for the amount. Assume standard US coin denominations.
function Get-Tender {
    Param (
        $Change,
        $CoinValues
    )
    $Coins = 0
    $SortedCoinValues = $CoinValues | Sort-Object -Descending
    $SortedCoinValues | ForEach-Object {
        if ($Change -ge $_) {
            $Coins += [int][math]::floor($Change / $_)
            $Change = $Change % $_
        }
    } 
    Write-Output $Coins
}