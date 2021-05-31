
## Code book for the Getting and Cleaning Data Course Project

## Data

Obtained here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
Details here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## Script

The run_analysis.R script performs all steps required in the project:

1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement. 
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive variable names. 
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

More details in the README file

## Variables and summaries calculated

x.train and y.train: variables with provided train data. They were read as table in lines 29 and 30, respectively.

x.test and y.test: variables with provided test data. They were read as table in lines 32 and 33, respectively.

subject.train and subject.test: variables with provided data for train and test subjects. They were read as table in lines 35 and 36, respectively.

features and labels: variables with provided data for features and labels. They were read as table in lines 38 and 39, respectively. The second column values of features were used as column names for the test datasets (lines 43 and 44)

all.train: variable with data produced after merging all train datasets provided, using column binding, in line 49 (step 1).

all.test: variable with data produced after merging all test datasets provided, using column binding, in line 50 (step 1).

all.data: variable with data produced after row binding all datasets provided, in line 51 (step 1).

sub.data: variable containing a subset of the full dataset, as indicated in step 2. Subseting was done with grepl looking for patterns in columns with required characters, lines 54 and 55. Activity numbers originally provided were replaced by descriptive ones, as indicated in step 3, using gsub, lines from 61 to 74. Gsub was also used to change column names to more descriptive ones, as indicated in step 4, in lines 78:86.

tidy.data: second, independent tidy data set with the average of each variable for each activity and each subject from the sub.data table, as indicated in step 5. The dplyr package group_by function was used first and then used with summarise_all to calculate the means, lines 93 and 94. Table was then saved as "TidyData.txt".








