
$json = @'
[
    {
      "Server": "LAX-WEB01",
      "Software": ["Adobe","Java","Flash","Chrome","IE","Norton"]
    },
    {
      "Server": "LAX-WEB02",
      "Software": ["Java","Norton","Flash"]
    },
    {
      "Server": "LAX-WEB03",
      "Software": ["Flash","IE","Chrome","Norton","Adobe"]
    },
    {
      "Server": "LAX-WEB04",
      "Software": ["Java","Adobe","Flash","IE","Chrome"]
    },
    {
      "Server": "LAX-WEB05",
      "Software": ["Flash","Norton","Jira"]
    }
]
'@

$serverDataList = $json | ConvertFrom-Json

# Task 1: Find and output the server objects (or server names) that have 'Java' installed

$serverDataList | Where-Object {$_.Software -contains 'Java'} | Select-Object Server

# Task 2: Find and output the list of software that every server has in common. So in the example above, Flash is the only piece of software that every single server has.

$Software = $serverDataList[0].Software
$Count = $serverDataList.count
foreach ($item in $Software) {
	if (($serverDataList | Where-Object {$_.Software -contains $item}).count -eq $Count) {
  	Write-Output $item
  }
}

# Task 3.A: Find the list of software that is installed on exactly three servers.

$Hash = @{}
foreach ($server in $serverDataList) {
	foreach ($item in $server.Software) {
  	if (-not $Hash[$item]) {
    	$Hash[$item] = 1
    } else {
    	++$Hash[$item]
    }  
	}
}
$Hash.keys | ForEach-Object {
  if ($Hash[$_] -eq 3) {Write-Output $_}
}

# Task 3.B: Find the list of software that is installed on exactly three servers, but this time return the servers hosting that software.

$Hash2 = @{}
for ($x = 0; $x -lt $serverDataList.Count; ++$x) {
  $Server = $serverDataList[$x].Server
	foreach ($Product in $serverDataList[$x].Software) {
  	if (-not $Hash2[$Product]) {
      $Hash2[$Product] = [System.Collections.ArrayList]@()
    }
    $Hash2[$Product] += $Server  
	}
}

$Hash2.GetEnumerator().Name | ForEach-Object {
  if ($Hash2[$_].Count -eq 3) {
    Write-Output $_ $Hash2[$_]
  }
}
