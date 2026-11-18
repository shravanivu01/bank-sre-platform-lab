#!/usr/bin/env bash
# Prints the HTTP status of each URL given (or of three defaults).
set -uo pipefail
urls=("$@")
if [ ${#urls[@]} -eq 0 ]; then
  urls=("http://localhost:8080/" "http://localhost:8080/health.json" "http://localhost:8080/does-not-exist")
fi
for u in "${urls[@]}"; do
  code=$(curl -s -o /dev/null -w "%{http_code}" "$u" || true)
  echo "$code  $u"
done
