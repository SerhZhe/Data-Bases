INSERT INTO Invoice(clientId,dateInvoice,startDate,endDate,price)
VALUES(2,'2023-06-01','2023-05-01','2023-05-31',100000)
GO

SELECT * FROM Invoice
GO

BEGIN TRAN
UPDATE dbo.Payment
SET sumPay*=1.1
GO
ROLLBACK TRAN