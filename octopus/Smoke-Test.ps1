# Octopus step "Smoke test": fail the deployment if fewer than 2 pods are Running.
$kube = Join-Path $env:USERPROFILE ".kube\config"
$ns = $OctopusParameters["Namespace"]
$pods = kubectl --kubeconfig $kube get pods -n $ns -l app=balance-service --no-headers
Write-Host $pods
if (($pods | Select-String "Running").Count -lt 2) { throw "Fewer than 2 healthy pods in $ns" }
Write-Host "Smoke test passed in $ns"
