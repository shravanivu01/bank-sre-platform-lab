-- Run as SYSTEM in FREEPDB1. Lab-only passwords for a throwaway local container;
-- in production they would come from a secrets vault.

-- Storage
CREATE TABLESPACE bank_data DATAFILE 'bank_data01.dbf' SIZE 50M AUTOEXTEND ON NEXT 10M MAXSIZE 500M;

-- Schema owner (owns the tables; nobody logs in as it day to day)
CREATE USER bank_owner IDENTIFIED BY "Owner_Lab_2026" DEFAULT TABLESPACE bank_data QUOTA 200M ON bank_data;
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE TO bank_owner;

-- Roles: least privilege
CREATE ROLE bank_app_rw;
CREATE ROLE bank_report_ro;

-- Application user and read-only reporting user
CREATE USER bank_app IDENTIFIED BY "App_Lab_2026";
CREATE USER bank_report IDENTIFIED BY "Report_Lab_2026";
GRANT CREATE SESSION TO bank_app, bank_report;
GRANT bank_app_rw TO bank_app;
GRANT bank_report_ro TO bank_report;
EXIT
