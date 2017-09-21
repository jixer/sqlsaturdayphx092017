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


# Read the saved model from DB
modelQuery <- "SELECT TOP 1 model FROM [tip_prediction_model]"
modelBin <- sqlQuery(mychannel, modelQuery)
model <- unserialize(modelBin$model[[1]])


#Load the data taht we want to run prediction for
pendingRidesQuery <- "select * from [pending_rides]";
pendingRidesDataset <- sqlQuery(channel = mychannel, query = pendingRidesQuery)

# Run the model against the data to execute prediction
scoredData <- predict(model, pendingRidesDataset, type="response")
pendingRidesDataset$tip_probability = scoredData

# Save the predictions back to SQL
sqlUpdate(mychannel, pendingRidesDataset, tablename = "pending_rides", index = "medallion")