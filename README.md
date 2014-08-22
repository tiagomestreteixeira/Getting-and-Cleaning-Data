Getting-and-Cleaning-Data
=========================







## 
### This repo contains:

- run_analysis.R
- README.md
- CodeBook.
- finalAveragesDataSet.txt






## 
### Instructions to run the Script

The R Script run_analysis.R reads the HCI HAR DataSet (the raw data), perform extraction, merging and grouping from data fields and columns. After the analysis, writes the result to the finalAveragesDataSet.txt file. 

Information about the DataSet can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.
DataSet can be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

Unzipping the Dataset.zip (file containing the HCI HAR DataSet), creates the folder "UCI HAR Dataset" that have all the data ready to be processed. The run_analysis.R file is meant to be in the same directory of "UCI HAR Dataset".

The Script ran under RStudio (0.98) under Mac OSX Mavericks and was not tested under other Systems.


### What the Script Does?

1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement.
3) Uses descriptive activity names to name the activities in the data set.
4) Appropriately labels the data set with descriptive variable names. 
5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject, presenting the output to a file : finalAveragesDataSet.txt 


### Data Set directory structure

./HCI HAR DataSet

- features.txt: All Features.
- activity_labels.txt: All Activities.

./HCI HAR DataSet/train/

- X_train.txt: Training set.
- y_train.txt: Training Activities.
- subject_train.txt: Training Subjects.

./HCI HAR DataSet/test/

- X_test.txt: Testing set.
- y_test.txt: Testing Activities.
- subject_test.txt: Testing Subjects.