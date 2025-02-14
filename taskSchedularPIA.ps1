$nomTache = "Definir MTU PIA"
$descriptionTache = "Definir le MTU de PIA a 1440"
$principalTache = New-ScheduledTaskPrincipal -UserId 'NT AUTHORITY\SYSTEM' -LogonType ServiceAccount -RunLevel Highest

$classe = cimclass MSFT_TaskEventTrigger root/Microsoft/Windows/TaskScheduler
$declencheurEvenement = $classe | New-CimInstance -ClientOnly
$declencheurEvenement.Enabled = $true
$declencheurEvenement.Subscription = @"
<QueryList>
    <Query Id="0" Path="Microsoft-Windows-NetworkProfile/Operational">
        <Select Path="Microsoft-Windows-NetworkProfile/Operational">
            *[System[EventID=10000]]
        </Select>
    </Query>
</QueryList>
"@

$actionTache = New-ScheduledTaskAction -Execute "cmd.exe" -Argument "/c echo off && netsh interface ipv4 set subinterface ""wgpia0"" mtu=1440 && exit"

$tache = New-ScheduledTask -Trigger $declencheurEvenement -Action $actionTache -Description $descriptionTache -Principal $principalTache
Register-ScheduledTask -TaskName $nomTache -InputObject $tache
