#wait for the SQL Server to come up
sleep 10s

#run the setup script to create the DB and the schema in the DB
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Pass@word1 -d master -i setup.sql

#import the data from the first csv file
/opt/mssql-tools/bin/bcp ride_share.dbo.completed_rides in "completed_rides.csv" -c -t',' -r'\r\n' -S localhost -U sa -P Pass@word1

#import the data from the second csv file
/opt/mssql-tools/bin/bcp ride_share.dbo.pending_rides in "pending_rides.csv" -c -t',' -r'\r\n' -S localhost -U sa -P Pass@word1
