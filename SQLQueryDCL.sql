/*
1) �������� 3-4 ���������� ����������� �� �� �������� ��������� ���� ������� �����,
--�� ��������� ����� ������������� (�������� �� ������ ��������� ������).

2) ������ ��������� ������������ ������ �������� �� �� ������� �����.
3) �������� 2-3 ����� ��� ��� ������������ �� �� �������� ��������� ���� ������� �����, �� ����������� � ���� ������.
4) ������ �������� ������ ��������� �����.
5) ���������� ������������ ���.
6) ³�������� � ����������� �������, �� ����� ����������� ����� ����. ������������ � ��������� �������� ����������� ������������� ������� ����� ����.
7) ³�������� ���� � �����������. ������������ � ��������� � ����������� �������, �� ���� ��������� ���� ����������� (�� ����� ����), �� ��������� � ����� �������, �� ���� ���� ����� ���� ����� ����.
8) �������� ����. �������� �����������.
*/

--user customer
--user admin
--user accountant

--CREATE USER
USE TV
GO

CREATE LOGIN customer
WITH
PASSWORD='12345' MUST_CHANGE,
DEFAULT_LANGUAGE=English,
DEFAULT_DATABASE=TV,
CHECK_EXPIRATION=ON,
CHECK_POLICY=ON
GO

CREATE USER customer1 FOR LOGIN customer
GO

CREATE LOGIN [admin]
WITH
PASSWORD='12345' MUST_CHANGE,
DEFAULT_LANGUAGE=English,
DEFAULT_DATABASE=TV,
CHECK_EXPIRATION=ON,
CHECK_POLICY=ON
GO

CREATE USER admin1 FOR LOGIN [admin]
GO


CREATE LOGIN accounter
WITH
PASSWORD='12345' MUST_CHANGE,
DEFAULT_LANGUAGE=English,
DEFAULT_DATABASE=TV,
CHECK_EXPIRATION=ON,
CHECK_POLICY=ON
GO

CREATE USER accounter1 FOR LOGIN accounter
GO

CREATE LOGIN MainAccounter
WITH
PASSWORD='12345' MUST_CHANGE,
DEFAULT_LANGUAGE=English,
DEFAULT_DATABASE=TV,
CHECK_EXPIRATION=ON,
CHECK_POLICY=ON
GO

CREATE USER accounter3 FOR LOGIN MainAccounter
GO






CREATE ROLE CustomerRole
GO


CREATE ROLE AdminRole
GO


CREATE ROLE AccounterRole
GO



ALTER ROLE CustomerRole ADD MEMBER customer1
ALTER ROLE AdminRole ADD MEMBER admin1
ALTER ROLE AccounterRole ADD MEMBER accounter1
ALTER ROLE AccounterRole ADD MEMBER accounter3
GO


GRANT INSERT
ON OrderMovie
TO CustomerRole

GRANT INSERT
ON OrderChannel
TO CustomerRole

GRANT INSERT
ON OrderChannelPackage
TO CustomerRole


GRANT CONTROL
ON DATABASE::TV
TO AdminRole
GO


DENY INSERT
ON OrderMovie
TO AdminRole
GO

DENY INSERT
ON OrderChannel
TO AdminRole
GO

DENY INSERT
ON OrderChannelPackage
TO AdminRole
GO

DENY INSERT
ON Invoice
TO AdminRole
GO 

DENY UPDATE
ON Invoice
TO AdminRole
GO 

DENY INSERT
ON Payment
TO AdminRole
GO 

DENY DELETE
ON OrderMovie
TO AdminRole
GO

DENY DELETE
ON OrderChannel
TO AdminRole
GO

DENY DELETE
ON OrderChannelPackage
TO AdminRole
GO

DENY DELETE
ON Invoice
TO AdminRole
GO 

DENY DELETE
ON Payment
TO AdminRole
GO 

REVOKE INSERT
ON Invoice
TO AccounterRole
GO

GRANT SELECT
ON Invoice
TO AccounterRole
GO

GRANT SELECT
ON Payment
TO AccounterRole
GO

GRANT INSERT
ON Payment
TO AccounterRole
GO

GRANT UPDATE
ON Payment
TO AccounterRole
GO

GRANT DELETE
ON Payment
TO AccounterRole
GO

ALTER ROLE AccounterRole
DROP MEMBER accounter1
GO

GRANT SELECT
ON Invoice
TO accounter1
GO

BEGIN TRAN
DROP USER customer1
GO
DROP ROLE CustomerRole
GO
ALTER ROLE CustomerRole ADD MEMBER customer1
GO
ROLLBACK TRAN