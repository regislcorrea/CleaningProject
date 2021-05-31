
# Getting and Cleaning Data Course Project

# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.
# 
# One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
#   
#   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
# 
# Here are the data for the project:
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
# 
# You should create one R script called run_analysis.R that does the following. 
# 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Download provided file:
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = "data.zip")

### Unziping file:
unzip(zipfile="data.zip",exdir="./")

### Merging the training and the test sets to create one data set.
x.train = read.table("./UCI HAR Dataset/train/X_train.txt")
y.train = read.table("./UCI HAR Dataset/train/y_train.txt")

x.test = read.table("./UCI HAR Dataset/test/X_test.txt")
y.test = read.table("./UCI HAR Dataset/test/y_test.txt")

subject.test = read.table("./UCI HAR Dataset/test/subject_test.txt")
subject.train = read.table("./UCI HAR Dataset/train/subject_train.txt")

features = read.table('./UCI HAR Dataset/features.txt')
labels = read.table('./UCI HAR Dataset/activity_labels.txt')

colnames(subject.train) = "subject"

colnames(x.test) = features$V2 
colnames(y.test) = "activity"
colnames(subject.test) = "subject"

#Merging all data

all.train = cbind(y.train, subject.train, x.train)
all.test = cbind(y.test, subject.test, x.test)
all.data = rbind(all.train,all.test)

### Extracting only the measurements on the mean and standard deviation for each measurement.
sub.data = all.data[,grepl("mean\\(\\)", colnames(all.data)) | grepl("std\\(\\)", colnames(all.data))| 
                           grepl("activity", colnames(all.data))| grepl("subject", colnames(all.data))]


### Using descriptive activity names to name the activities in the data set

# gsub values in the activity col and replace by the descriptive one
activity = sub.data$activity
activity = gsub("1","WALKING",activity)
activity = gsub("2","WALKING_UPSTAIRS",activity)
activity = gsub("3","WALKING_DOWNSTAIRS",activity)
activity = gsub("4","SITTING",activity)
activity = gsub("5","STANDING",activity)
activity = gsub("6","LAYING",activity)

# remove actual activity col
sub.data = sub.data[,-1]
# add new activity col
sub.data$activity = activity
# bring new activity col back as the first col
sub.data = sub.data[,c(68,1:67)]


### Labeling the data set with descriptive variable names. 
names(sub.data) = gsub("^t", "time", names(sub.data))
names(sub.data) = gsub("^f", "freq", names(sub.data))
names(sub.data) = gsub("Acc", "Accelerometer", names(sub.data))
names(sub.data) = gsub("Gyro", "Gyroscope", names(sub.data))
names(sub.data) = gsub("Mag", "Magnitude", names(sub.data))
names(sub.data) = gsub("-mean", "Mean", names(sub.data))
names(sub.data) = gsub("-std", "STD", names(sub.data))
names(sub.data) = gsub("-freq", "Frequency", names(sub.data))
names(sub.data) = gsub("\\()", "", names(sub.data))


### independent tidy data set with the average of each variable for each activity and each subject

library(dplyr)

tidy.data = group_by(sub.data, subject, activity)
tidy.data = summarise_all(tidy.data, funs(mean))


write.table(tidy.data, "TidyData.txt", row.name=FALSE)


