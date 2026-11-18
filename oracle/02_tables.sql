-- Run as SYSTEM in FREEPDB1.
CREATE TABLE bank_owner.accounts (
  account_id   NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  holder_name  VARCHAR2(100) NOT NULL,
  balance_nzd  NUMBER(12,2) DEFAULT 0 NOT NULL,
  updated_at   TIMESTAMP DEFAULT SYSTIMESTAMP
);
INSERT INTO bank_owner.accounts (holder_name, balance_nzd) VALUES ('Demo Customer A', 1520.75);
INSERT INTO bank_owner.accounts (holder_name, balance_nzd) VALUES ('Demo Customer B', 98.10);
COMMIT;

-- The app can read and change rows but not delete them or drop the table; reporting is read-only.
GRANT SELECT, INSERT, UPDATE ON bank_owner.accounts TO bank_app_rw;
GRANT SELECT ON bank_owner.accounts TO bank_report_ro;
EXIT
