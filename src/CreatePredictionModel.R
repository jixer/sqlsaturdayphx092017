# Prerequisites: You have installed SQL Server 2016 R Services or SQL Server 2017 Machine Learning Services with the R language
# Install required R libraries for this walkthrough if they are not installed. 
if (!('RODBC' %in% rownames(installed.packages()))){
  install.packages('RODBC')
}
if (!('caret' %in% rownames(installed.packages()))){
  install.packages('caret')
}
if (!('rpart' %in% rownames(installed.packages()))){
  install.packages('rpart')
}

# Reference required libraries
library(rpart)
library(RODBC)
library(caret)


# Define the connection string
# This walkthrough requires SQL authentication
mychannel <- odbcConnect(dsn = "SqlMain", uid = "sa", pwd = "Pass@word1")


#Define a DataSource (from a select query) to be used to explore the data and generate features from.
#Keep in mind that dataset is just a reference to the result dataset from the SQL query.
completedRidesQuery <- "select top 1000 * from completed_rides";
completedRidesDataset <- sqlQuery(channel = mychannel, query = completedRidesQuery)


# Set the random seed for reproducibility of randomness.
set.seed(2345, "L'Ecuyer-CMRG")
completedRidesDataset$tipped = as.numeric(completedRidesDataset$tipped)
completedRidesDataset$fare_amount = as.numeric(completedRidesDataset$fare_amount)
completedRidesDataset$passenger_count = as.numeric(completedRidesDataset$passenger_count)
completedRidesDataset$trip_distance = as.numeric(completedRidesDataset$trip_distance)
completedRidesDataset$trip_time_in_secs = as.numeric(completedRidesDataset$trip_time_in_secs)


# Create the model
model <- formula(paste("tipped ~ passenger_count + trip_time_in_secs + trip_distance + fare_amount"))
logitObj <- glm(model, data = completedRidesDataset, family = binomial)


# Persist model by calling a stored procedure from SQL
modelbin <- serialize(logitObj, NULL)
modelbinstr <- paste(modelbin, collapse = "")
q <- paste("EXEC PersistModel @m='", modelbinstr, "'", sep = "")
sqlQuery(mychannel, q)
