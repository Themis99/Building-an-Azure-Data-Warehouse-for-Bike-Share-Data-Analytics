CREATE TABLE [dbo].[payment_fact]
(
    payment_id INT NOT NULL,  
	payment_date_id VARCHAR(1000) NOT NULL,
    user_id BIGINT NOT NULL,
    amount DECIMAL NOT NULL
)