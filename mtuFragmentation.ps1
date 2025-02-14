# TailleBufferMax = [1420, 1500, 9000]
$TailleBufferMax = 1500
$AdresseTest      = "1.1.1.1"

$DernierMinBuffer=$TailleBufferMin
$DernierMaxBuffer=$TailleBufferMax
$MaxTrouve=$false

[int]$TailleBuffer = ($TailleBufferMax - 0) / 2
while($MaxTrouve -eq $false){
    try{
        $Reponse = ping $AdresseTest -n 1 -f -l $TailleBuffer
        if($Reponse -like "*fragmented*"){throw}
        if($DernierMinBuffer -eq $TailleBuffer){
            $MaxTrouve = $true
            Write-Host "trouvé."
            break
        } else {
            Write-Host "$TailleBuffer" -ForegroundColor Green -NoNewline
            $DernierMinBuffer = $TailleBuffer
            $TailleBuffer = $TailleBuffer + (($DernierMaxBuffer - $DernierMinBuffer) / 2)
        }
    } catch {
        Write-Host "$TailleBuffer" -ForegroundColor Red -NoNewline
        $DernierMaxBuffer = $TailleBuffer
        if(($DernierMaxBuffer - $DernierMinBuffer) -le 3){
            $TailleBuffer = $TailleBuffer - 1
        } else {
            $TailleBuffer = $DernierMinBuffer + (($DernierMaxBuffer - $DernierMinBuffer) / 2)
        }
    }
    Write-Host "," -ForegroundColor Gray -NoNewline
}
Write-Host "MTU: $TailleBuffer"
Write-Host "MTU+EnTetes: $($TailleBuffer + 28)"
