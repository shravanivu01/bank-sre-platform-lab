# Octopus runbook "Health check": routine view of every pod in the cluster.
$kube = Join-Path $env:USERPROFILE ".kube\config"
kubectl --kubeconfig $kube get pods -A
kubectl --kubeconfig $kube get nodes
