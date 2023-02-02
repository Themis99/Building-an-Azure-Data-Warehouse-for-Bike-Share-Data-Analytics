INSERT INTO [dbo].[payment_fact]
SELECT
p.payment_id,
t.time_id,
p.rider_id,
p.amount
FROM [dbo].[staging_payment] as p
JOIN dbo.time_dim as t ON t.inserted_date = p.payment_date


