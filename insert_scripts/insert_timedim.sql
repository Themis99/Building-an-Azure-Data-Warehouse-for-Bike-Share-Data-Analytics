with test_dates as (select DISTINCT test.payment_date as custom_dates FROM
					(SELECT payment_date   FROM [dbo].[staging_payment] 
					UNION 
					SELECT started_at FROM [dbo].[staging_trip]
					UNION
					SELECT ended_at FROM [dbo].[staging_trip] ) AS test)

INSERT INTO [dbo].[time_dim] 
SELECT NEWID(), 
custom_dates, 
DAY(cast(custom_dates AS DATETIME2)),
MONTH(cast(custom_dates AS DATETIME2)),
DATEPART(quarter,cast(custom_dates AS DATETIME2)),
YEAR(cast(custom_dates AS DATETIME2)),
DATEPART(weekday,cast(custom_dates AS DATETIME2))
FROM test_dates

