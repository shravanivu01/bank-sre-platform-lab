# Octopus Deploy setup (Octopus Cloud free trial)

Octopus is configured in its web UI, so this folder holds the step scripts and the settings to recreate it.

| Item | Setting |
|---|---|
| Environments | `Development`, `Production` |
| Lifecycle | `Bank Standard`: phase 1 Development, phase 2 Production |
| Deployment target | Windows Polling Tentacle on the lab laptop, target tag `k8s-deployer`, both environments |
| Project | `balance-service`, lifecycle `Bank Standard` |
| Variable `Namespace` | `bank-dev` (Development), `bank-prod` (Production) |
| Variable `ManifestUrl` | `https://raw.githubusercontent.com/shravanivu01/bank-sre-platform-lab/main/k8s/balance-service.yaml` |

## Deployment process (in this order)

1. **Change approval**: Manual Intervention Required, Production only. "Confirm change ticket and smoke test in Dev before approving."
2. **Deploy to Kubernetes**: Run a Script, target tag `k8s-deployer`, PowerShell: [`Deploy-ToKubernetes.ps1`](Deploy-ToKubernetes.ps1)
3. **Smoke test**: Run a Script, target tag `k8s-deployer`, PowerShell: [`Smoke-Test.ps1`](Smoke-Test.ps1)

Runbook **Health check**: [`Runbook-HealthCheck.ps1`](Runbook-HealthCheck.ps1)

## Release flow

Create release `1.0.0`, deploy to Development, check pods, then promote the **same** release to Production. Octopus stops at Change approval until a named person approves, and the audit log records who deployed what and when.
