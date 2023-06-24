USE TV;
GO

CREATE OR ALTER PROCEDURE GenerateInvoice @clientId bigint, @month int, @year int
AS
BEGIN
	DECLARE @sumMovie money=0, @sumChannel money=0, @totalSumChannel money=0, @sumPackage money=0, @totalSumPackage money=0, @totalSum money=0;
	DECLARE @firstMonthDay date, @lastMonthDay date;
	DECLARE @orderStartDate date, @orderEndDate date, @price money;

	SET @firstMonthDay=CAST(@year AS char(4))+'.'+CAST(@month AS CHAR(2))+'.'+'01';
	SET @lastMonthDay=EOMONTH(@firstMonthDay);


	SELECT @sumMovie=SUM(Movie.price) FROM OrderMovie JOIN Movie ON OrderMovie.movieId=Movie.id
	WHERE OrderMovie.clientId=@clientId AND YEAR(OrderMovie.orderDate)=@year AND MONTH(OrderMovie.orderDate)=@month;
	
	DECLARE clientOrderChannel CURSOR
	FOR
	SELECT OrderChannel.startDate, OrderChannel.endDate, Chanel.price
	FROM OrderChannel JOIN Chanel ON OrderChannel.channelId=Chanel.id
	WHERE OrderChannel.clientId=@clientId  AND
	NOT(OrderChannel.endDate<@firstMonthDay OR OrderChannel.startDate>@lastMonthDay);

	OPEN clientOrderChannel;

	FETCH NEXT FROM clientOrderChannel INTO @orderStartDate, @orderEndDate, @price;

	WHILE(@@FETCH_STATUS=0)
	BEGIN
		IF(@orderStartDate<=@firstMonthDay AND (@orderEndDate>=@lastMonthDay OR @orderEndDate IS NULL) )
			SET @sumChannel=@price;
		IF(@orderStartDate>@firstMonthDay AND (@orderEndDate>=@lastMonthDay OR @orderEndDate IS NULL))
			SET @sumChannel=(DATEDIFF(dd, @orderStartDate, @lastMonthDay)+1)*@price/(DATEDIFF(dd,@firstMonthDay, @lastMonthDay)+1);
		IF(@orderStartDate<=@firstMonthDay AND @orderEndDate<@lastMonthDay )
			SET @sumChannel=(DATEDIFF(dd, @firstMonthDay, @orderEndDate)+1)*@price/(DATEDIFF(dd,@firstMonthDay, @lastMonthDay)+1);
		IF(@orderStartDate>@firstMonthDay AND @orderEndDate<@lastMonthDay)
			SET @sumChannel=(DATEDIFF(dd, @orderStartDate, @orderEndDate)+1)*@price/(DATEDIFF(dd,@firstMonthDay, @lastMonthDay)+1);
		SET @totalSumChannel+=@sumChannel;
		FETCH NEXT FROM clientOrderChannel INTO @orderStartDate, @orderEndDate, @price;
	END

	CLOSE clientOrderChannel;
	DEALLOCATE clientOrderChannel;

	DECLARE clientOrderPackage CURSOR
	FOR
	SELECT OrderChannelPackage.startDate, OrderChannelPackage.endDate, ChanelPackage.price
	FROM OrderChannelPackage JOIN ChanelPackage ON OrderChannelPackage.chanelPackageId=ChanelPackage.id
	WHERE OrderChannelPackage.clientId=@clientId  AND
	NOT(OrderChannelPackage.endDate<@firstMonthDay OR OrderChannelPackage.startDate>@lastMonthDay);

	OPEN clientOrderPackage;

	FETCH NEXT FROM clientOrderPackage INTO @orderStartDate, @orderEndDate, @price;

	WHILE(@@FETCH_STATUS=0)
	BEGIN
		IF(@orderStartDate<=@firstMonthDay AND (@orderEndDate>=@lastMonthDay OR @orderEndDate IS NULL) )
			SET @sumPackage=@price;
		IF(@orderStartDate>@firstMonthDay AND (@orderEndDate>=@lastMonthDay OR @orderEndDate IS NULL))
			SET @sumPackage=(DATEDIFF(dd, @orderStartDate, @lastMonthDay)+1)*@price/(DATEDIFF(dd,@firstMonthDay, @lastMonthDay)+1);
		IF(@orderStartDate<=@firstMonthDay AND @orderEndDate<@lastMonthDay )
			SET @sumPackage=(DATEDIFF(dd, @firstMonthDay, @orderEndDate)+1)*@price/(DATEDIFF(dd,@firstMonthDay, @lastMonthDay)+1);
		IF(@orderStartDate>@firstMonthDay AND @orderEndDate<@lastMonthDay)
			SET @sumPackage=(DATEDIFF(dd, @orderStartDate, @orderEndDate)+1)*@price/(DATEDIFF(dd,@firstMonthDay, @lastMonthDay)+1);
		SET @totalSumPackage+=@sumPackage;
		FETCH NEXT FROM clientOrderPackage INTO @orderStartDate, @orderEndDate, @price;
	END

	CLOSE clientOrderPackage;
	DEALLOCATE clientOrderPackage;

	SET @totalSum=@sumMovie+@totalSumChannel+@totalSumPackage;

	IF(@totalSum>0)
		IF EXISTS(SELECT * FROM Invoice WHERE Invoice.clientId=@clientId AND Invoice.startDate=@firstMonthDay AND Invoice.endDate=@lastMonthDay)
		UPDATE Invoice
		SET price=@totalSum, dateInvoice=GETDATE()
		WHERE clientId=@clientId AND startDate=@firstMonthDay AND endDate=@lastMonthDay;
		ELSE
		INSERT INTO Invoice(clientId,dateInvoice,startDate,endDate,price)
		VALUES (@clientId,GETDATE(),@firstMonthDay,@lastMonthDay,@totalSum);
END

GO



/*EXECUTE GenerateInvoice 1,04,2023;
GO*/

CREATE OR ALTER PROCEDURE GenerateAllInvoice @month int, @year int
AS
BEGIN
	DECLARE @client bigint;
	DECLARE clients CURSOR
	FOR
	SELECT Client.id FROM Client;

	OPEN clients;

	FETCH NEXT FROM clients INTO @client

	WHILE(@@FETCH_STATUS=0)
	BEGIN
		EXECUTE GenerateInvoice @client,@month,@year;
		FETCH NEXT FROM clients INTO @client;
	END

	CLOSE clients;
	DEALLOCATE clients;

END
GO


DECLARE @month int=4, @year int=2023;
EXECUTE GenerateAllInvoice @month,@year;
SELECT *
FROM Invoice
WHERE MONTH(endDate)=@month AND YEAR(endDate)=@year;

GO