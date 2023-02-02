CREATE TABLE [dbo].[time_dim]
(
    time_id UNIQUEIDENTIFIER NOT NULL,
	inserted_date VARCHAR(1000),
	inserted_day INT,
	inserted_month INT,
	inserted_quarter INT,
	inserted_year INT,
	inserted_weekday INT
	CONSTRAINT primary_key_time PRIMARY KEY NONCLUSTERED (time_id) NOT ENFORCED
)

