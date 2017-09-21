USE [master];
GO

CREATE DATABASE ride_share;
GO

USE ride_share;
GO

CREATE TABLE completed_rides
(
       medallion varchar(50) not null,
       hack_license varchar(50)  not null,
       vendor_id char(3),
       rate_code char(3),
       store_and_fwd_flag char(3),
       pickup_datetime datetime  not null,
       dropoff_datetime datetime, 
       passenger_count int,
       trip_time_in_secs bigint,
       trip_distance float,
       pickup_longitude varchar(30),
       pickup_latitude varchar(30),
       dropoff_longitude varchar(30),
       dropoff_latitude varchar(30),
       payment_type char(3),
       fare_amount float,
       surcharge float,
       mta_tax float,
       tolls_amount float,
       total_amount float,
       tip_amount float,
       tipped int,
       tip_class int
);
GO

CREATE TABLE pending_rides
(
       medallion varchar(50) not null,
       hack_license varchar(50)  not null,
       vendor_id char(3),
       rate_code char(3),
       store_and_fwd_flag char(3),
       pickup_datetime datetime  not null,
       dropoff_datetime datetime, 
       passenger_count int,
       trip_time_in_secs bigint,
       trip_distance float,
       pickup_longitude varchar(30),
       pickup_latitude varchar(30),
       dropoff_longitude varchar(30),
       dropoff_latitude varchar(30),
       payment_type char(3),
       fare_amount float,
       surcharge float,
       mta_tax float,
       tolls_amount float,
       total_amount float,
       tip_probability float
);
GO

CREATE TABLE tip_prediction_model
(
	model varbinary(max) not null
);
GO

CREATE PROCEDURE [dbo].[PersistModel]
@m NVARCHAR(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	TRUNCATE TABLE tip_prediction_model;
    
	INSERT tip_prediction_model(model) 
	VALUES (CONVERT(VARBINARY(MAX), @m, 2))
END
GO