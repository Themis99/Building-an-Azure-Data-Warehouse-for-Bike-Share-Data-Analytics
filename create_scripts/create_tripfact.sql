CREATE TABLE [dbo].[trip_fact]
(
    ride_id NVARCHAR(4000) NOT NULL,
    user_id BIGINT NOT NULL,
	start_station_id NVARCHAR(4000) NOT NULL,
	end_station_id NVARCHAR(4000) NOT NULL,
    start_ride_id VARCHAR(1000) NOT NULL,
    end_ride_id VARCHAR(1000) NOT NULL,
    duration FLOAT NOT NULL,
    ridable_type VARCHAR(100) NOT NULL,
    rider_age INT NOT NULL
)