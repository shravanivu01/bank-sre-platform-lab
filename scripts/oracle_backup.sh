#!/usr/bin/env bash
# Nightly logical backup of the bank_owner schema with 7-day retention.
# The password is read from inside the container's own environment, never written here.
set -euo pipefail
STAMP=$(date +%Y%m%d_%H%M)
DUMP="bank_owner_${STAMP}.dmp"
docker exec oracle bash -c "expdp system/\"\${ORACLE_PASSWORD}\"@localhost/FREEPDB1 \
  schemas=BANK_OWNER directory=DATA_PUMP_DIR dumpfile=${DUMP} logfile=bank_owner_${STAMP}.log"
mkdir -p "$HOME/oracle_backups"
DIR=$(docker exec oracle bash -c "find /opt/oracle -name '${DUMP}' 2>/dev/null | head -1 | xargs dirname")
docker cp "oracle:${DIR}/${DUMP}" "$HOME/oracle_backups/"
find "$HOME/oracle_backups" -name 'bank_owner_*.dmp' -mtime +7 -delete
echo "Backup complete: $HOME/oracle_backups/${DUMP}"
