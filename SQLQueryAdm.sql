SELECT *
FROM TV.dbo.Client
GO


BEGIN TRAN
UPDATE Movie
SET price*=1.1
GO

SELECT * FROM Movie
GO

ROLLBACK TRAN
GO

SELECT * FROM Movie
GO

INSERT INTO OrderMovie(movieId,clientId)
VALUES (3,3)
GO

INSERT INTO Movie([name],category,price,ageLimit,release)
VALUES('Spider-Man','action',110,14,'2023-01-30')
GO

EXECUTE dbo.GenerateAllInvoice 05,2023
GO

BEGIN TRAN
UPDATE dbo.Invoice
SET price/=10
GO