do {

    $defaultStartTime = Get-Date -Hour 0 -Minute 0 -Second 0

    $filter = Read-Host "Search for"

    $startTime = Read-Host "Start Date (default of $defaultStartTime)"

    if ($startTime.Length -eq 0 -or !($startTime -as [DateTime])) {
        $startTime = $defaultStartTime.ToString()
    }

    $defaultEndTime = Get-Date $startTime -Hour 23 -Minute 59 -Second 59

    $endTime = Read-Host "End Date (default of $defaultEndTime)"

    if ($endTime.Length -eq 0 -or !($endTime -as [DateTime])) {
        $endTime = $defaultEndTime.ToString()
    }

    $outputMethod = Read-Host "Output to File (y/n)"

    $filter = "*" + $filter + "*"

    Write-Host "Searching Application Event Log..."

    #$events = Get-EventLog -LogName “Application” -Source “Aptify*” -Message $filter -After $startTime -Before $endTime
    $events = Get-WinEvent -FilterHashtable @{LogName="Application"; ProviderName="Aptify*"; StartTime="$startTime"; EndTime="$endTime"}

    $eventsCount = if ($events.Count -lt 1) { 0 } else { $events.Count }

    $found = 0;

    if ($eventsCount -gt 0) {
        Write-Host "Filtering Results..."

        $results = "<Events>"

        foreach ($event in $events) { 
            if ($event[0].Properties[0].Value -like $filter) {
		        $results += @"
		        <Event>
			        <DateTime>$($event.TimeCreated)</DateTime>
			        <Source>$($event.ProviderName)</Source>
			        <EntryType>$($event.LevelDisplayName)</EntryType>
			        <Message><![CDATA[[
				        $($event.Properties[0].Value -replace "`n", "`r`n" )
			        ]]>
			        </Message>
		        </Event>
"@
                $found++
            }
        }

        $results += "</Events>"
    }

    Write-Host "$found result(s) were found that match your search criteria."


    if ($found -gt 0 -and ($outputMethod -eq "y" -or $outputMethod -eq "yes")) {

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
        if ($found -gt 0) {
            $results
        }
    }

    Write-Host " "
    Write-Host " "

    $response = Read-Host "Press enter to start another search, or type quit to exit..."
}
while ($response -ne "quit")
