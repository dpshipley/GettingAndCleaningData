# GettingAndCleaningData
This is a Repo for the submission of the course project for the Getting and Cleaning Data course.  The purpose of this project is to demonstrate ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis by creating one R script called run_analysis.R.

Raw data for this project:
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description of the data and how it was collected:    
  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Prior to running the run_analysis R script, download and extract the raw data zip file.  Locate the following files and save into the R working directory.
 - subject_train.txt
 - X_train.txt
 - y_train.txt
 - activity_labels.txt
 - features.txt
 - subject_test.txt
 - X_test.txt
 - y_test.txt

The following libraries are required:
 - library(data.table)
 - library(reshape2)
 - library(plyr)
 - 
Project Summary:
 - read and combine the train and test data sets (X_train and X_test) into a single data frame
 - read and combine the train and test activity data sets (y_train and y_test) into a single data frame
 - read and combine the train and test subject ID's (subject_train and subject_test) into a single data frame
 - read features labels (features) and combine with train/test data frame
 - extract a subset that only includes the measurements on the mean and standard deviation features
 - combine the train/test activity data frame with the activity label (activity_labels)
 - append the subject ID to the appropriate row in the train/test data frame
 - melt and reshape the data frame to create a tidy data set that includes an average for each variable
 - appropriately label the data set to correct errors and remove restricted characters 
 - write output txt file (tidy_dataset.txt)


