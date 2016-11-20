# Code Book For Getting & Cleansing Data Assignment

## Study Design

### Summary choices

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Code Book

The run_analysis.R file contains a single external function run_analysis() which performs the cleanup of the Human Activit Recognition Using Smartphones Data sourced from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script doesn't support any arguments and the two packages (data.table and dplyr) that it depends on are checked for by the script and loaded if they are not present. However it does expect the working directory to be set to the top level folder containing the following files and direcotories as unpacked from the above url.

Features.txt
Activity Labels.txt
Test
Train

Below is an example of how to run the script and obtain the cleansed data file.
```
data<-run_analysis()
write.table(data, "outputData.txt")
```
To read the output into R again the following commands can be used.
```
data <- read.table("outputData.txt", header = TRUE) 
View(data)
```

## Cleansing Process

1. First the features file is loaded. This list of names is then stripped of the "(", ")", "-" and "," characters. These are replaced with the "_" character to make the names more readable. Then makeN.names is used to make the colum names unique.
2. The run_analysis function contains a separate function this it uses internally to process the two different files, test and train. This is run on both folders.
  1. The three data files are loaded (x, y and subject) and the colum names from step one ore applied to the x data set.
  2. The columns are selected based on whether they contain the text "std" or "mean".
  3. The three data sets are joined together
  4. The descriptive activity names are then linked to the data set.
3. Once step two has been done for test and train the two resulting data sets are joined together.
4. The average of each variable is then calculated for each activity and each subject. And the results are arranged.

## Resulting columns
The following is a list of the columns in the resulting data set.

1. subject_id - Contains in integer identifier for a subject.
2. activity - Contains a textual description of the activity being performed.

The Remaining Rows are the mean of the original rows that were selected in the cleansing process. Descriptions of the original data set can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

