USE [ride_share];
GO

SELECT * FROM sys.tables;

SELECT COUNT(*) AS completed_rides_count 
FROM completed_rides;
SELECT TOP 10 * 
FROM completed_rides;

SELECT COUNT(*) AS pending_rides_count 
FROM pending_rides;
SELECT * 
FROM pending_rides;

SELECT * FROM tip_prediction_model;