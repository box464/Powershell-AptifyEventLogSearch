$defaultStartTime = Get-Date -Hour 0 -Minute 0 -Second 0
$defaultEndTime = Get-Date -Hour 23 -Minute 59 -Second 59

$filter = Read-Host "Search for"
$startTime = Read-Host "Start Date (default of $defaultStartTime)"
$endTime = Read-Host "End Date (default of $defaultEndTime)"

if ($startTime.Length -eq 0 -or !($startTime -as [DateTime])) {
    $startTime = $defaultStartTime.ToString()
}

if ($endTime.Length -eq 0 -or !($endDate -as [DateTime])) {
    $endTime = $defaultEndTime.ToString()
}

$outputMethod = Read-Host "Output to File (y/n)"

$events = Get-WinEvent -FilterHashtable @{LogName="Application"; ProviderName="Aptify*"; StartTime="$startTime"; EndTime="$endTime"}
$results = "<Events>"
ForEach ($event in $events) {
    $xml = [xml]$event.ToXml()
    $data = $xml.Event.EventData.Data.ToString()
 
    if ($data -like "*" + $filter + "*") {
        
        $xml.Event.EventData.Data = $data

        $results += $xml.Event.OuterXml
    }
}
$results = $results + "</Events>"


if ($outputMethod -eq "y" -or $outMethod -eq "yes") {
    $filePath = $Env:userprofile + "\desktop\AptifyErrorSearch-" + $filter.Replace(" ", "") + "-" + $startTime.Replace("/", "").Replace(":", "").Replace(" AM", "").Replace(" PM", "").Replace(" ", "") + "_" + $endTime.Replace("/", "").Replace(":", "").Replace(" AM", "").Replace(" PM", "").Replace(" ", "") + ".xml"

    $xmlResults = [xml]$results
    
    #This nicely formats the XML file
    #NOTE: The Aptify Exception Data only has NewLine endings, and therefore does not look good in Notepad.
    #Open this XML file in NotePad++ or any web browser to see the a better view of the data.
    $xmlResults.Save($filePath)

    Write-Host "File saved to $filePath"
}
else {
    $results
}


