# Octopus step "Deploy to Kubernetes" (runs on the Tentacle with target tag k8s-deployer).
# Namespace and ManifestUrl are Octopus project variables; Namespace is scoped per environment.
$kube = Join-Path $env:USERPROFILE ".kube\config"
$ns = $OctopusParameters["Namespace"]
$url = $OctopusParameters["ManifestUrl"]
Write-Host "Release $($OctopusParameters['Octopus.Release.Number']) to $ns"
kubectl --kubeconfig $kube apply -n $ns -f $url
kubectl --kubeconfig $kube rollout status deployment/balance-service -n $ns --timeout=120s
if ($LASTEXITCODE -ne 0) { throw "Rollout failed in $ns" }
