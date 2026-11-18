#!/usr/bin/env bash
# Checks that a service answers on its health URL and that the disk is not full.
set -euo pipefail
URL="${1:-http://localhost:8080/health.json}"
code=$(curl -s -o /dev/null -w "%{http_code}" "$URL" || true)
echo "HTTP status for $URL: $code"
if [ "$code" -ne 200 ]; then echo "ALERT: service is not healthy"; exit 1; fi
usage=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
echo "Disk usage on /: ${usage}%"
if [ "$usage" -gt 90 ]; then echo "ALERT: disk above 90%"; exit 1; fi
echo "All checks passed"
