function Get-ReversedLinkedList {
    Param(
        $HeadNode  # has .next and .value. .next is another node, or $null if the end of the list.
    )

    $ReversedNodes = @()
    $ReversedNodes += [PSCustomObject]@{
        next = $null
        value = $HeadNode.value
    }
    $NextNode = $HeadNode
    do {
        $NextNode = $NextNode.next
        $ReversedNodes += [PSCustomObject]@{
            next = $($ReversedNodes[-1])
            value = $NextNode.value
        }
    } until (-not $NextNode.Next)
    Write-Output $($ReversedNodes[-1])
}

# set up sample linked list nodes and link them
$head = [PSCustomObject]@{
    next = $null
    value = "whatever1"
}
$n2 = [PSCustomObject]@{
    next = $null
    value = "whatever2"
}
$n3 = [PSCustomObject]@{
    next = $null
    value = "whatever3"
}
$head.next = $n2
$n2.next = $n3
# Now that the sample is set up, call the function (to be written) to get the reversed list head.
$reversed = Get-ReversedLinkedList -HeadNode $head
# Tests: All of these should output $true if the linked list was properly reversed!
$reversed.value -eq 'whatever3'
$reversed.next.value -eq 'whatever2'
$reversed.next.next.value -eq 'whatever1'
$null -eq $reversed.next.next.next