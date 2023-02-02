-- Analyze how much time is spent per ride

	-- Based on date and time factors such as day of week and time of day
	SELECT tf.ride_id, t.inserted_weekday,tf.duration
	FROM [dbo].[trip_fact] as tf
	JOIN [dbo].[time_dim] as t ON tf.end_ride_id = t.time_id
	WHERE t.inserted_weekday = 5

	-- Based on which station is the starting and / or ending station
	SELECT ss.station_name as station_start,se.station_name as station_end, tf.duration
	FROM [dbo].[trip_fact] as tf
	JOIN [dbo].[station_dim] AS ss ON ss.station_id = tf.start_station_id
	JOIN [dbo].[station_dim] AS se ON se.station_id = tf.end_station_id
	WHERE ss.station_name = 'Michigan Ave & Washington St' AND se.station_name = 'Michigan Ave & Washington St'
	

	-- Based on age of the rider at time of the ride
	SELECT tf.ride_id,tf.rider_age,tf.duration
	FROM [dbo].[trip_fact] as tf
	WHERE rider_age = '26'
		
	-- Based on whether the rider is a member or a casual rider
	SELECT tf.ride_id,tf.duration,u.is_member
	FROM [dbo].[trip_fact] as tf
	JOIN [dbo].[user_dim] as u ON u.user_id = tf.user_id
	WHERE u.is_member = 'TRUE'

-- Analyze how much money is spent

	-- Per month, quarter, year
	SELECT p.amount,t.inserted_month,t.inserted_quarter,t.inserted_year
	FROM [dbo].[payment_fact] as p
	JOIN [dbo].[time_dim] as t ON t.time_id = p.payment_date_id
	WHERE t.inserted_month = '1'AND t.inserted_quarter='1' AND t.inserted_year='2019'

	-- Per member, based on the age of the rider at account start
	SELECT u.user_id ,ABS(DATEDIFF(YEAR,u.birthdate,u.account_start_date)) as rider_age_at_account_start,sum(p.amount) as tl_amount
	FROM [dbo].[payment_fact] as p
	JOIN [dbo].[user_dim] as u ON u.user_id = p.user_id
	WHERE ABS(DATEDIFF(YEAR,u.birthdate,u.account_start_date)) = '21'
	GROUP BY u.user_id,ABS(DATEDIFF(YEAR,u.birthdate,u.account_start_date))

 -- Analyze how much money is spent per member
	
	-- Based on how many rides the rider averages per month
	SELECT sub.member,avg(sub.monthly_amount) as avg_spent_amount,avg(riders_per_month) as avg_num_riders,sub.ofmonth
	FROM ( SELECT u.user_id as member,sum(p.amount) as monthly_amount,count(tf.ride_id) as riders_per_month,tt.inserted_month as ofmonth,tt.inserted_year
			FROM [dbo].[user_dim] as u
			JOIN [dbo].[payment_fact] as p ON p.user_id = u.user_id
			JOIN [dbo].[trip_fact] as tf ON tf.user_id = u.user_id
			JOIN [dbo].[time_dim] as tt ON tf.end_ride_id = tt.time_id
			GROUP BY u.user_id,tt.inserted_month,tt.inserted_year
		  ) as sub
	GROUP BY sub.member,sub.ofmonth
	HAVING avg(riders_per_month) = '20'

	--  Analyze how much money is spent per member
	SELECT sub.member,avg(sub.monthly_amount) as avg_spent_amount,sub.minutes_per_month as mins_month,sub.ofmonth
	FROM ( SELECT u.user_id as member,sum(p.amount) as monthly_amount,sum(tf.duration) as minutes_per_month,tt.inserted_month as ofmonth,tt.inserted_year
			FROM [dbo].[user_dim] as u
			JOIN [dbo].[payment_fact] as p ON p.user_id = u.user_id
			JOIN [dbo].[trip_fact] as tf ON tf.user_id = u.user_id
			JOIN [dbo].[time_dim] as tt ON tf.end_ride_id = tt.time_id
			GROUP BY u.user_id,tt.inserted_month,tt.inserted_year
		  ) as sub
	GROUP BY sub.member,sub.ofmonth,sub.minutes_per_month
	HAVING sub.minutes_per_month = '5'
