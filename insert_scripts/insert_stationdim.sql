INSERT INTO [dbo].[station_dim]
	SELECT
	s.station_id,
	s.station_name,
	s.lat,
	s.long
FROM [dbo].[staging_station] AS s
