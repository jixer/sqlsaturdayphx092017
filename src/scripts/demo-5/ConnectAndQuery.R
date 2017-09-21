# Prerequisites: You have installed SQL Server 2016 R Services or SQL Server 2017 Machine Learning Services with the R language
# Install required R libraries for this walkthrough if they are not installed. 
if (!('RODBC' %in% rownames(installed.packages()))){
  install.packages('RODBC')
}

# Reference required libraries
library(RODBC)

# Define the connection string
# This walkthrough requires SQL authentication
mychannel <- odbcConnect(dsn = "SqlMain", uid = "sa", pwd = "Pass@word1")


#Define a DataSource (from a select query) to be used to explore the data and generate features from.
#Keep in mind that dataset is just a reference to the result dataset from the SQL query.
completedRidesQuery <- "select top 10 * from completed_rides";
completedRidesDataset <- sqlQuery(channel = mychannel, query = completedRidesQuery)


# Close the channel
close(mychannel)