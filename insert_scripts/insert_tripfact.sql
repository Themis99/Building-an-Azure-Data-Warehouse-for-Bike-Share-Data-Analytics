INSERT INTO [dbo].[trip_fact]
SELECT
	t.trip_id,
	t.rider_id,
	t.start_station_id,
	t.end_station_id,
	start_ride.time_id,
	end_ride.time_id,
	ABS(DATEDIFF(MINUTE,cast(t.ended_at AS DATETIME2),cast(t.started_at AS DATETIME2))),
	t.ridable_type,
	ABS(DATEDIFF(year,cast(t.started_at AS DATETIME2),cast(r.birthday AS DATETIME2)))
FROM [dbo].[staging_trip] AS t
JOIN [dbo].[staging_rider] AS r ON r.rider_id = t.rider_id
JOIN [dbo].[time_dim] AS start_ride ON start_ride.inserted_date = t.started_at
JOIN [dbo].[time_dim] AS end_ride ON end_ride.inserted_date = t.ended_at

