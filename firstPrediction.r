setwd("~/Dropbox/Kaggle Work/Events/2013_Strata_Santa_Clara/talk/spam/");
library('ggplot2');
library('imputation');

# Read data
train <- read.csv("train.csv", header=FALSE);
test <- read.csv("test.csv", header=FALSE);
trainLabels <- read.csv("train_labels.csv", header=FALSE);

# Impute NaNs
train[train=="NaN"] <- NA;
test[test=="NaN"] <- NA;
train <- kNNImpute(train, k=3)[1]$x;
test <- kNNImpute(test, k=3)[1]$x;

# Look at correlation + activity
C <- as.numeric(cor(x=trainLabels,y=train));
S <- colSums(train > 1)
qplot(x=C, y=S, label=as.character(1:100), geom="text");

# Submission function
makeSubmission <- function(A,name){
  write.table(A,paste(as.character(name),".csv",sep=''),row.names=FALSE,col.names=FALSE)};

# Here goes nothing
makeSubmission(test[,36], "example_submission");