This document describes the analysis performed in the run_analysis.R document used to create the tidy_data.txt file.
This document is associated with the course project for the Getting and Cleaning Data Class from Coursera. 
Codebook.md provides information on all of the variables in the tidy_data.csv 

The run_analysis.R file performs the following operations on the dataset obtained from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

1. It merges the training and the test sets to create one data set.
2. It extracts only the measurements on the mean and standard deviation for each measurement.
3. It uses descriptive activity names to name the activities in the data set
4. It labels the data set with descriptive variable names provided in the raw datasets.
5.  From the data set in step 4, it creates a second, independent tidy data set with the average of 
	each variable for each activity and each subject. This file is called tidy_data.csv

The run_analysis.R document contains comments describing when each step occurs as well as checks to ensure
the operations worked properly. 