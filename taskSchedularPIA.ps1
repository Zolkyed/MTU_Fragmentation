$taskName = "Set PIA MTU"
$taskDescription = "Set PIA MTU to 1440"
$taskPrincipal = New-ScheduledTaskPrincipal -UserId 'NT AUTHORITY\SYSTEM' -LogonType ServiceAccount -RunLevel Highest

$class = cimclass MSFT_TaskEventTrigger root/Microsoft/Windows/TaskScheduler
$Trigger_onEvent = $class | New-CimInstance -ClientOnly
$trigger_onEvent.Enabled = $true
$trigger_onEvent.Subscription = @"
<QueryList>
    <Query Id="0" Path="Microsoft-Windows-NetworkProfile/Operational">
        <Select Path="Microsoft-Windows-NetworkProfile/Operational">
            *[System[EventID=10000]]
        </Select>
    </Query>
</QueryList>
"@

$taskAction = New-ScheduledTaskAction -Execute "cmd.exe" -Argument "/c echo off && netsh interface ipv4 set subinterface ""wgpia0"" mtu=1440 && exit"

$task = New-ScheduledTask -Trigger $Trigger_onEvent -Action $taskAction -Description $taskDescription -Principal $taskPrincipal
Register-ScheduledTask -TaskName $taskName -InputObject $task
