$defaultStartTime = Get-Date -Hour 0 -Minute 0 -Second 0
$defaultEndTime = Get-Date -Hour 23 -Minute 59 -Second 59

$filter = Read-Host "Search for"
$startTime = Read-Host "Start Date (default of $defaultStartTime)"
$endTime = Read-Host "End Date (default of $defaultEndTime)"

$endTim

if ($startTime.Length -eq 0 -or !($startTime -as [DateTime])) {
    $startTime = $defaultStartTime.ToString()
}

if ($endTime.Length -eq 0 -or !($endDate -as [DateTime])) {
    $endTime = $defaultEndTime.ToString()
}

$outputMethod = Read-Host "Output to File (y/n)"

$filter = "*" + $filter + "*"

$events = Get-EventLog -LogName “Application” -Source “Aptify*” -Message $filter -After $startTime -Before $endTime
#$events = Get-WinEvent -FilterHashtable @{LogName="Application"; ProviderName="Aptify*"; StartTime="$startTime"; EndTime="$endTime"}


$results = "<Events>"

foreach ($event in $events) { 
    $results += @"
    <Event>
        <DateTime>$($event.TimeGenerated)</DateTime>
        <Source>$($event.Source)</Source>
        <EntryType>$($event.EntryType)</EntryType>
        <Message><![CDATA[[
            $($event.Message -replace "`n", "`r`n" )
        ]]>
        </Message>
    </Event>
"@
}

$results += "</Events>"

if ($outputMethod -eq "y" -or $outMethod -eq "yes") {

    $filterName = $filter -replace '[^A-Za-z0-9-_\.\[\]]', ''
    $startTimeName = $startTime -replace '[^A-Za-z0-9-_\.\[\]]', ''
    $endTimeName = $endTime -replace '[^A-Za-z0-9-_\.\[\]]', ''
    $userName = $env:USERNAME -replace '[^A-Za-z0-9-_\.\[\]]', ''
    $filePath = $Env:userprofile + "\desktop\AptifyErrorSearch_" + $userName + "_" + $filterName + "_" + $startTimeName + "_" + $endTimeName + ".xml"

    $xmlResults = [xml]$results

    $xmlResults.Save($filePath)

    Write-Host "File saved to $filePath"
}
else {
    $results
}
