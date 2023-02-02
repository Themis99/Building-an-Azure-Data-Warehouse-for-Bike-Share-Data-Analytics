CREATE TABLE [dbo].[user_dim]
(

    user_id BIGINT NOT NULL,
    address VARCHAR(100) NOT NULL,
    first_name NVARCHAR(4000) NOT NULL,
    last_name NVARCHAR(4000) NOT NULL,
    birthdate DATE NOT NULL,
    is_member BIT NOT NULL,
    account_start_date DATE NOT NULL,
    account_end_date DATE
)
