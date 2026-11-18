-- Daily health checks. Run as SYSTEM in FREEPDB1.
SET LINESIZE 200 PAGESIZE 100
-- Tablespace usage
SELECT df.tablespace_name, ROUND(SUM(df.bytes)/1024/1024) size_mb, ROUND(NVL(fs.free_mb,0)) free_mb
FROM dba_data_files df
LEFT JOIN (SELECT tablespace_name, SUM(bytes)/1024/1024 free_mb FROM dba_free_space GROUP BY tablespace_name) fs
  ON df.tablespace_name = fs.tablespace_name
GROUP BY df.tablespace_name, fs.free_mb;
-- Who is connected
SELECT sid, serial#, username, status, program FROM v$session WHERE username IS NOT NULL;
-- Blocking sessions
SELECT sid, blocking_session, event FROM v$session WHERE blocking_session IS NOT NULL;
EXIT
