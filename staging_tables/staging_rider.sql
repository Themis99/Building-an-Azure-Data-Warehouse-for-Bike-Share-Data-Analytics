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

CREATE EXTERNAL TABLE staging_rider (
	[rider_id] bigint,
	[first_name] nvarchar(4000),
	[last_name] nvarchar(4000),
	[address] nvarchar(4000),
	[birthday] VARCHAR(100),
	[account_start_date] VARCHAR(100),
	[account_end_date] VARCHAR(100),
	[is_member] bit
	)
	WITH (
	LOCATION = 'publicrider.txt',
	DATA_SOURCE = [themisfile_themislake_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM dbo.staging_rider
GO