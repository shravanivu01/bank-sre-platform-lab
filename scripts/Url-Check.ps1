# Prints the HTTP status of each URL (PowerShell version of url_check.sh).
param(
  [string[]]$Urls = @("http://localhost:8080/", "http://localhost:8080/health.json", "http://localhost:8080/does-not-exist")
)
foreach ($u in $Urls) {
  try {
    $code = (Invoke-WebRequest -Uri $u -UseBasicParsing -TimeoutSec 5).StatusCode
  } catch {
    if ($_.Exception.Response) { $code = [int]$_.Exception.Response.StatusCode } else { $code = "000" }
  }
  Write-Output "$code  $u"
}
