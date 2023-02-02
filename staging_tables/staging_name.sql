IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 USE_TYPE_DEFAULT = FALSE
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'themisfile_themislake_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [themisfile_themislake_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://themisfile@themislake.dfs.core.windows.net', 
		TYPE = HADOOP 
	)
GO

CREATE EXTERNAL TABLE staging_payment (
	[payment_id] bigint,
	[payment_date] VARCHAR(100),
	[amount] float,
	[rider_id] bigint
	)
	WITH (
	LOCATION = 'publicpayment.txt',
	DATA_SOURCE = [themisfile_themislake_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM dbo.staging_payment
GO