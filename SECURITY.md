# Vulnerability management process (lab)

1. **Find:** Trivy scans every image in CI and fails the build on critical CVEs; Dependabot alerts and secret scanning are on; hosts are checked with `apt list --upgradable`.
2. **Assess:** rate by CVSS severity and exposure (internet-facing? customer data?).
3. **Prioritise:** Critical within 7 days, High within 30 days (example targets; a bank sets its own policy).
4. **Fix:** update the base image or package, or apply a workaround with a documented, time-limited exception.
5. **Verify:** rescan, confirm the finding is gone, and record it.

Example: `trivy image --severity HIGH,CRITICAL nginx:1.20` (old image, many findings) compared with a scan of the current `balance-service` image. Reports are saved in `docs/vuln-before.txt` and `docs/vuln-after.txt`.
