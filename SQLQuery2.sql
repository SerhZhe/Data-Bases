/*
—творити запити типу:
Х	SELECT на баз≥ одн≥Їњ таблиц≥ з використанн€м сортуванн€, накладенн€м умов з≥ звТ€зками OR та AND.
Х	SELECT з виводом обчислюваних пол≥в (вираз≥в) в колонках результату.
Х	SELECT на баз≥ к≥лькох таблиць з використанн€м сортуванн€, накладенн€м умов з≥ звТ€зками OR та AND.
Х	SELECT на баз≥ к≥лькох таблиць з типом поЇднанн€ Outer Join.
Х	SELECT з використанн€м оператор≥в Like, Between, In, Exists, All, Any.
Х	SELECT з використанн€м п≥дсумовуванн€ та групуванн€.
Х	SELECT з використанн€м п≥д-запит≥в в частин≥ Where.
Х	SELECT з використанн€м п≥д-запит≥в в частин≥ From.
Х	≥Їрарх≥чний SELECT запит.
Х	SELECT запит типу CrossTab.
Х	UPDATE на баз≥ одн≥Їњ таблиц≥.
Х	UPDATE на баз≥ к≥лькох таблиць.
Х	Append (INSERT) дл€ додаванн€ запис≥в з €вно вказаними значенн€ми.
Х	Append (INSERT) дл€ додаванн€ запис≥в з ≥нших таблиць.
Х	DELETE дл€ видаленн€ вс≥х даних з таблиц≥.
Х	DELETE дл€ видаленн€ вибраних запис≥в таблиц≥.

Х	–ейтинговий зв≥т по трансльованих програмах, к≥лькост≥ та категор≥€х показаних нових к≥ноф≥льм≥в та сумарну оплату за њх перегл€д.
Х	—писок боржник≥в з вказанн€м суми њх загальноњ заборгованост≥ та заборгованост≥ за останн≥й розрахунковий пер≥од (напр., останн≥й м≥с€ць).

*/

--як коротше одним запитом написати
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

--–ейтинговий зв≥т по трансльованих програмах, к≥лькост≥ та категор≥€х показаних нових к≥ноф≥льм≥в та сумарну оплату за њх перегл€д.
--програми(записи в ф≥льми)
SELECT Movie.id, Movie.name, COUNT(*) [Amount of views], SUM(Movie.price) [Earning from movie]

FROM Movie JOIN OrderMovie ON Movie.id=OrderMovie.movieId
WHERE DATEDIFF(YYYY, Movie.release, GETDATE())<=1
GROUP BY Movie.id, Movie.name
ORDER BY 4 DESC
GO

--¬ивести ф≥льми €к≥ н≥разу не замовл€лис€
SELECT *
FROM Movie
WHERE Movie.id NOT IN (SELECT DISTINCT OrderMovie.movieId FROM OrderMovie);
GO

--«меншити варт≥сть ф≥льм≥в €к≥ н≥разу не замовл€лис€
--I
--дати пер≥од €кщо ф≥льм новий
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

--4 кл≥Їнт замовл€Ї те що замовл€в 3 кл≥Їнт
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