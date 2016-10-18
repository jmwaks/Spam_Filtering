setwd("~/Documents/Kaggle/Kaggle");
library('ggplot2');
library('mice');
library('randomForest');

# Read data
train <- read.csv("train.csv", header=FALSE);
test <- read.csv("test.csv", header=FALSE);
trainLabels <- read.csv("train_labels.csv", header=FALSE);

# Impute NaNs with mean value
train[train=="NaN"] <- NA;
test[test=="NaN"] <- NA;
train <- mice(train, m = 5, maxit=3,meth='pmm' ,seed = 5)
test <- mice(test, m = 5, maxit=3,meth='pmm' ,seed = 5);

# Train Random forest
rf.model <- randomForest(trainLabels$V1 ~ .,
                         data=train,
                         ntree = 10,
                         mtry = 5 );
# Make the predictions
predictions <- predict(rf.model, test)

# Submission function
makeSubmission <- function(A,name){
  write.table(A,paste(as.character(name),".csv",sep=''),row.names=FALSE,col.names=FALSE)};

# Here goes something
makeSubmission(predictions, "example_submission2");