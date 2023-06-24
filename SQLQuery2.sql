/*
�������� ������ ����:
�	SELECT �� ��� ���� ������� � ������������� ����������, ����������� ���� � �������� OR �� AND.
�	SELECT � ������� ������������ ���� (������) � �������� ����������.
�	SELECT �� ��� ������ ������� � ������������� ����������, ����������� ���� � �������� OR �� AND.
�	SELECT �� ��� ������ ������� � ����� �������� Outer Join.
�	SELECT � ������������� ��������� Like, Between, In, Exists, All, Any.
�	SELECT � ������������� ������������� �� ����������.
�	SELECT � ������������� ��-������ � ������ Where.
�	SELECT � ������������� ��-������ � ������ From.
�	����������� SELECT �����.
�	SELECT ����� ���� CrossTab.
�	UPDATE �� ��� ���� �������.
�	UPDATE �� ��� ������ �������.
�	Append (INSERT) ��� ��������� ������ � ���� ��������� ����������.
�	Append (INSERT) ��� ��������� ������ � ����� �������.
�	DELETE ��� ��������� ��� ����� � �������.
�	DELETE ��� ��������� �������� ������ �������.

�	����������� ��� �� ������������� ���������, ������� �� ��������� ��������� ����� ��������� �� ������� ������ �� �� ��������.
�	������ �������� � ��������� ���� �� �������� ������������� �� ������������� �� ������� ������������� ����� (����., ������� �����).

*/

--�� ������� ����� ������� ��������
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
LastPeriodInvoice(clientId,  lastInvoiceSum, lastInvoicePaymentSum )
AS
(
SELECT clientId,price, ISNULL((SELECT SUM(Payment.sumPay) FROM Payment WHERE Payment.invoiceId=Invoice.id),0)
FROM Invoice
WHERE MONTH(DATEADD(MM,-1,GETDATE()))=MONTH(dateInvoice) AND YEAR(DATEADD(MM,-1,GETDATE()))=YEAR(dateInvoice)
)

SELECT Client.name [Client Name], InvoicesCalc.clientId [Client ID], InvoicesCalc.sumForPayment [wholeInvoicePay],PaymentCalc.PaymentSum [wholeClientPay], InvoicesCalc.sumForPayment-PaymentCalc.PaymentSum [whole debt], LastPeriodInvoice.lastInvoiceSum, LastPeriodInvoice.lastInvoicePaymentSum, LastPeriodInvoice.lastInvoiceSum-LastPeriodInvoice.lastInvoicePaymentSum [last period debt]  
FROM Client JOIN  InvoicesCalc ON Client.id=InvoicesCalc.clientId JOIN PaymentCalc ON InvoicesCalc.clientId=PaymentCalc.clientId  JOIN LastPeriodInvoice ON LastPeriodInvoice.clientId=Client.id
WHERE InvoicesCalc.sumForPayment-PaymentCalc.PaymentSum>0
GO

--����������� ��� �� ������������� ���������, ������� �� ��������� ��������� ����� ��������� �� ������� ������ �� �� ��������.
--��������(������ � ������)
SELECT Movie.id, Movie.name, COUNT(*) [Amount of views], SUM(Movie.price) [Earning from movie]

FROM Movie JOIN OrderMovie ON Movie.id=OrderMovie.movieId
WHERE DATEDIFF(YYYY, Movie.release, GETDATE())<=1
GROUP BY Movie.id, Movie.name
ORDER BY 4 DESC
GO

--������� ������ �� ����� �� �����������
SELECT *
FROM Movie
WHERE Movie.id NOT IN (SELECT DISTINCT OrderMovie.movieId FROM OrderMovie);
GO

--�������� ������� ������ �� ����� �� �����������
--I
--���� ����� ���� ����� �����
UPDATE Movie
SET price=0.3*price
WHERE id IN (	SELECT Movie.id
				FROM Movie
				WHERE Movie.id NOT IN (SELECT DISTINCT OrderMovie.movieId FROM OrderMovie));
GO


SELECT * FROM Movie;
GO
--II
UPDATE Movie
SET price=0.3*price
FROM Movie LEFT JOIN OrderMovie ON Movie.id=OrderMovie.movieId 
WHERE OrderMovie.movieId IS NULL
GO

SELECT * FROM Movie;
GO

DELETE FROM OrderMovie
WHERE clientId=4;
GO

--4 �볺�� �������� �� �� �������� 3 �볺��
INSERT INTO OrderMovie(movieId,clientId)
SELECT DISTINCT  OrderMovie.movieId,4
FROM OrderMovie
WHERE OrderMovie.clientId=3
GO

SELECT * FROM OrderMovie WHERE clientId=3 OR clientId=4;

GO

SELECT * INTO Client_CPY
FROM Client;

SELECT * FROM Client_CPY


DELETE Client_CPY

SELECT * FROM Client_CPY

DROP TABLE Client_CPY
GO
--triger na banServ