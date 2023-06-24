CREATE OR ALTER FUNCTION DEBT(@clienId bigint) RETURNS TABLE
AS
return
WITH 
InvoicesCalc(clientId,sumForPayment)
AS
(SELECT clientId,SUM(price) FROM Invoice
GROUP BY clientId),
PaymentCalc(clientId,PaymentSum)
AS
(
SELECT clientId, ISNULL(SUM(Payment.sumPay),0) FROM Invoice LEFT JOIN Payment ON Invoice.id=Payment.invoiceId
GROUP BY clientId
),
LastPeriodInvoice(clientId,  last3MonthInvoiceSum )
AS
(
SELECT clientId,SUM(price)
FROM Invoice
WHERE	(MONTH(DATEADD(MM,-3,GETDATE()))=MONTH(dateInvoice) OR MONTH(DATEADD(MM,-2,GETDATE()))=MONTH(dateInvoice) OR MONTH(DATEADD(MM,-1,GETDATE()))=MONTH(dateInvoice))  
		AND 
		(YEAR(DATEADD(MM,-3,GETDATE()))=YEAR(dateInvoice) OR YEAR(DATEADD(MM,-2,GETDATE()))=YEAR(dateInvoice) OR YEAR(DATEADD(MM,-1,GETDATE()))=YEAR(dateInvoice))
GROUP BY clientId
)

SELECT  InvoicesCalc.clientId, InvoicesCalc.sumForPayment, PaymentCalc.PaymentSum, LastPeriodInvoice.last3MonthInvoiceSum
FROM   InvoicesCalc LEFT JOIN PaymentCalc ON InvoicesCalc.clientId=PaymentCalc.clientId LEFT JOIN LastPeriodInvoice ON LastPeriodInvoice.clientId=InvoicesCalc.clientId
WHERE InvoicesCalc.clientId=@clienId-- AND InvoicesCalc.sumForPayment-PaymentCalc.PaymentSum>=LastPeriodInvoice.last3MonthInvoiceSum
GO

CREATE OR ALTER TRIGGER Ban_ORDERMOVIE
ON dbo.OrderMovie
AFTER INSERT
AS
BEGIN
	DECLARE @clientId bigint;
	
	SELECT @clientId=clientId from inserted;
if(EXISTS(SELECT * FROM dbo.DEBT(@clientId) AS T WHERE T.sumForPayment-T.PaymentSum>=T.last3MonthInvoiceSum))
BEGIN

RAISERROR('You have critical debt,which exceeds your payments for last 3 months. Please pay!',16,1);
ROLLBACK TRANSACTION;
update Client
SET banServices=1
WHERE id=@clientId;
END

END
GO

CREATE OR ALTER TRIGGER Ban_ORDERCHANNEL
ON dbo.OrderChannel
AFTER INSERT
AS
BEGIN
	DECLARE @clientId bigint;
	
	SELECT @clientId=clientId from inserted;
if(EXISTS(SELECT * FROM dbo.DEBT(@clientId) AS T WHERE T.sumForPayment-T.PaymentSum>=T.last3MonthInvoiceSum))
BEGIN

RAISERROR('You have critical debt,which exceeds your payments for last 3 months. Please pay!',16,1);
ROLLBACK TRANSACTION;
update Client
SET banServices=1
WHERE id=@clientId;
END

END
GO

CREATE OR ALTER TRIGGER Ban_ORDERCHANNELPACKAGE
ON dbo.OrderChannelPackage
AFTER INSERT
AS
BEGIN
	DECLARE @clientId bigint;
	
	SELECT @clientId=clientId from inserted;
if(EXISTS(SELECT * FROM dbo.DEBT(@clientId) AS T WHERE T.sumForPayment-T.PaymentSum>=T.last3MonthInvoiceSum))
BEGIN

RAISERROR('You have critical debt,which exceeds your payments for last 3 months. Please pay!',16,1);
ROLLBACK TRANSACTION;
update Client
SET banServices=1
WHERE id=@clientId;
END

END
GO


CREATE OR ALTER TRIGGER ban_ORDERMOVIE_AGE ON dbo.OrderMovie
AFTER INSERT 
AS
BEGIN
DECLARE @clientId bigint, @movieId bigint, @birthDay date, @ageLimit tinyint;
	
	SELECT @clientId=clientId, @movieId=movieId from inserted;
	SELECT @birthDay=birthDay FROM Client Where id=@clientId;
	SELECT @ageLimit=ageLimit FROM Movie WHERE id=@movieId;
	IF(DATEDIFF(YYYY,@birthDay,GETDATE())<@ageLimit)
	BEGIN
	RAISERROR('You are too young!',16,1);
ROLLBACK TRANSACTION;
	END
END
GO

SELECT *
FROM dbo.DEBT(3)

EXECUTE dbo.GenerateAllInvoice 05,2023

SELECT *
FROM Invoice

INSERT INTO OrderMovie(movieId, clientId)
VALUES (2,1);

INSERT INTO OrderChannel(clientId,channelId,startDate,endDate)
VALUES (1,1,GETDATE(),'2023-06-30');

INSERT INTO OrderChannelPackage(clientId,chanelPackageId,startDate,endDate)
VALUES (1,1,GETDATE(),'2023-06-30');

INSERT INTO OrderMovie(movieId, clientId)
VALUES (2,3);
SELECT * FROM OrderMovie
WHERE clientId=3


select DATEDIFF(YYYY,'2020-01-01',GETDATE())