## Script to Process the UCI HAR DataSet. This work is part of the course: Getting and Cleaning Data
## Source of the DataSet: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
## Reads and Merges the training and the test sets to create one independent tidy data set.


#################################### 
### Reads Activities and Features ##
####################################

# Read the activities, result is a table with corresponding id of the activity and the activity itself
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
names(activities) <- c("ID_ACTIVITY","ACTIVITY") 

# Read the features, result is a table with corresponding id of the feature and the feature itself
features <- read.table("UCI HAR Dataset/features.txt")
names(features)<-c("ID_FEATURE", "FEATURE")


#################################### 
####### Reads the train set. #######
####################################

## Reads the train set features (features were read previously)  
train_X <- read.table("UCI HAR Dataset/train/X_train.txt")
names(train_X)<-features$FEATURE

## Reads the activity of train Subject
train_Y <- read.table("UCI HAR Dataset/train/y_train.txt")
names(train_Y)<-"ID_ACTIVITY"

## Reads each train Subject
train_Subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
names(train_Subject)<-"ID_SUBJECT"

##### Merge the Train dataSet into a Train dataSet with The train Subjects 
## Columns are "ID_SUBJECT","ID_ACTIVITY", then all the features (one per column)
train_set <- cbind(train_Subject, train_Y, train_X)


#################################### 
####### Reads the test set. #######
####################################

## Reads the test set features (features were read previously)  
test_X <- read.table("UCI HAR Dataset/test/X_test.txt")
names(test_X)<-features$FEATURE

## Reads the activity of test subject
test_Y <- read.table("UCI HAR Dataset/test/y_test.txt")
names(test_Y)<-"ID_ACTIVITY"

## Reads each train Subject
test_Subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
names(test_Subject)<-"ID_SUBJECT"

##### Merge the Test dataSet into a Test dataSet with the train Subject
## Columns are "ID_SUBJECT","ID_ACTIVITY", then all the features (one per column)
test_set <- cbind(test_Subject, test_Y, test_X)


#################################### 
## Merges train and test dataSets ##
####################################

### All in one big table
trainTestSet <- rbind(train_set,test_set)

### just keep the subject and activity id's, the mean and std measurements
# The regular expression : ID_SUBJECT|ID_ACTIVITY|mean|std identify any occurence of the 4
# character expressions: ID_SUBJECT ; ID_ACTIVITY ; mean ; std 
trainTestSet <- trainTestSet[,grep("ID_SUBJECT|ID_ACTIVITY|mean|std",names(trainTestSet))]

### Match or replace the ID_ACTIVITY with the Corresponding ACTIVITY
### @See http://stackoverflow.com/questions/14417612/r-replace-an-id-value-with-a-name
names(trainTestSet)[2]<-"ACTIVITY"
trainTestSet$ACTIVITY <- activities[match(trainTestSet$ACTIVITY,activities$ID_ACTIVITY),'ACTIVITY']

### Organize dataset with the average of each variable for each activity and each subject. 
### Organize data by ACTIVITY and ID_SUBJECT (melt converts each feature to a factor and the corresponding
### measurements and dcast to reshape the data) 
### (this solution avoids loops) 
### @See http://www.cookbook-r.com/Manipulating_data/Converting_data_between_wide_and_long_format/#problem
library(reshape2)
melted_features <- melt(trainTestSet, id.vars = c("ID_SUBJECT","ACTIVITY"), 
                                      variable.name="FEATURES", 
                                      value.name="FEATURES_MEASUREMENTS")

### Reshape, calculating averages, organizing data by ID_SUBJECT and ACTIVITY
finalAveragesDataSet <- dcast(melted_features, ID_SUBJECT + ACTIVITY ~ FEATURES,mean, value.var="FEATURES_MEASUREMENTS")


### Write tidy DataSet to a txt file: finalAveragesDataSet.txt
write.table(finalAveragesDataSet, "./finalAveragesDataSet.txt", row.names = FALSE)




