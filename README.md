## Building-an-Azure-Data-Warehouse-for-Bike-Share-Data-Analytics

Divvy is a bike sharing program in Chicago, Illinois USA that allows riders to purchase a pass at a kiosk or use a mobile application to unlock a bike at stations around the city and use the bike for a specified amount of time. The bikes can be returned to the same station or to another station. The City of Chicago makes the anonymized bike trip data publicly available for projects like this where we can analyze the data. due to the anonymity of the data, fake rider and account profiles, along with fake payment data, have been created to accompany the data from Divvy

The goal in this project is to develop a data warehouse solution using Azure Synapse Analytics and more specifically to:

- Design a star schema based on the business outcomes listed below;
- Import the data into Synapse;
- Transform the data into the star schema;
- View the reports from Analytics.

The business outcomes we are designing for are as follows:

1. Analyze how much time is spent per ride
- Based on date and time factors such as day of week and time of day
- Based on which station is the starting and / or ending station
- Based on age of the rider at time of the ride
- Based on whether the rider is a member or a casual rider
2. Analyze how much money is spent
- Per month, quarter, year
- Per member, based on the age of the rider at account start
3. Analyze how much money is spent per member
- Based on how many rides the rider averages per month
- Based on how many minutes the rider spends on a bike per month

# Dataset

The dataset looks like this:
![divvy-erd](https://user-images.githubusercontent.com/46052843/216280192-1c628ef1-e66a-49e1-b33f-7a1a13611a3a.png)

The initial data were in CSV format

# provided solution

The data from the original schema was transformed into the new schema presented below. The new schema has two fact tables one for trips (trip_fact) and the other for payments (payments_fact). The trip_fact table contains information about the trip such as the key of the start and end station, the type of ride, the start time key of the trip, and the end time key of the trip as well as other information such as the duration of the trip and the age of the rider in the time of the trip. The payment fact contains information about the payment of the ride such as the time of payment and the amount.

![Schema_final](https://user-images.githubusercontent.com/46052843/216283708-27725203-ac27-4456-abb3-6abdd4ed44b2.png)

Three other dimension tables were created. A dimension table related to users (users_dim) that contains information about the user such as name, birthday as well as other information about his/her subscription to the application such as whether he/she is a member or not and the start and end date of subscription. A dimension table (time_dim) stores information about each date such as day, month, quarter, year, and weekday. Last but not least, a dimension table (station_dim) contains information about each station such as name, latitude, and longitude.

# Azure warehouse
For the creation of the warehouse resources from Microsoft Azure were allocated. More specificaly an Azure Synapse Workspace was created (along with a Azure Storage Account) and a Dedicated SQL pools inside the Synapse Workspace. An postgres SQL database was created.

+++

For the ingestion process the storage account and the postgres SQL database were linked through the Azure synapse enviroment. The postgres SQL database was firstly populated with the data. Then the data is loaded from the Postgres SQL database to the storage account in CSV format. In this way, staging tables can be created for each CSV file. 



After the creation of the staging tables, the step of data transformation for the creation of the star schema as presented above.

# Files




