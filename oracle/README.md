# Oracle Free (lab)

```bash
# Start Oracle Free in Docker (pick your own lab password; it only lives on the laptop)
docker run -d --name oracle -p 1521:1521 -e ORACLE_PASSWORD='YourLabPassword1' gvenzl/oracle-free:23-slim
docker logs -f oracle            # wait for: DATABASE IS READY TO USE!  then Ctrl+C

# Create storage, users, roles and the demo table
docker cp oracle/. oracle:/tmp/sql/
docker exec -i oracle sqlplus -s system/'YourLabPassword1'@localhost/FREEPDB1 @/tmp/sql/01_setup.sql
docker exec -i oracle sqlplus -s system/'YourLabPassword1'@localhost/FREEPDB1 @/tmp/sql/02_tables.sql

# Prove least privilege: SELECT works, DELETE fails with ORA-01031
docker exec -it oracle sqlplus bank_report/Report_Lab_2026@localhost/FREEPDB1

# Health checks
docker exec -i oracle sqlplus -s system/'YourLabPassword1'@localhost/FREEPDB1 @/tmp/sql/03_health.sql

# Nightly backup (Data Pump), then schedule at 1 AM with crontab -e:
#   0 1 * * * $HOME/bank-sre-platform-lab/scripts/oracle_backup.sh >> $HOME/oracle_backups/backup.log 2>&1
./scripts/oracle_backup.sh

# Restore test: drop the table as SYSTEM, then import it back from the dump
#   DROP TABLE bank_owner.accounts PURGE;
docker exec oracle bash -c 'impdp system/"${ORACLE_PASSWORD}"@localhost/FREEPDB1 schemas=BANK_OWNER directory=DATA_PUMP_DIR dumpfile=DUMPFILE_NAME.dmp table_exists_action=replace'
#   SELECT COUNT(*) FROM bank_owner.accounts;   -- returns 2
```

Data Pump is a **logical** backup (schemas and tables). In production I would add **RMAN** physical backups in ARCHIVELOG mode for point-in-time recovery, copied off-site, with restores tested on a schedule.
