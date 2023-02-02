INSERT INTO [dbo].[user_dim] 
	SELECT 
	r.rider_id,
	r.address,
	r.first_name,
	r.last_name,
	cast(r.birthday AS DATETIME2),
	r.is_member,
	cast(r.account_start_date AS DATETIME2),
	cast(r.account_end_date AS DATETIME2)
FROM [dbo].[staging_rider] as r
