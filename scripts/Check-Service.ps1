# Windows check: is the service healthy, and is a named Windows service running?
param(
  [string]$Url = "http://localhost:8080/health.json",
  [string]$ServiceName = "com.docker.service"
)
try {
  $r = Invoke-WebRequest -Uri $Url -UseBasicParsing -TimeoutSec 5
  Write-Output "HTTP $($r.StatusCode) from $Url"
} catch { Write-Output "ALERT: $Url is not responding"; exit 1 }
$svc = Get-Service -Name $ServiceName -ErrorAction SilentlyContinue
if ($null -eq $svc -or $svc.Status -ne 'Running') { Write-Output "WARNING: $ServiceName is not running" }
else { Write-Output "$ServiceName is running" }
