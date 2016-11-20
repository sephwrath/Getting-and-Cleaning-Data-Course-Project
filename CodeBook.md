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
2.1. The three data files are loaded (x, y and subject) and the colum names from step one ore applied to the x data set.
2.2. The columns are selected based on whether they contain the text "std" or "mean".
2.3. The three data sets are joined together
2.4. The descriptive activity names are then linked to the data set.
3. Once step two has been done for test and train the two resulting data sets are joined together.
4. The average of each variable is then calculated for each activity and each subject. And the results are arranged.

## Resulting columns
The following is a list of the columns in the resulting data set.
[1] "subject_id"                          "activity"                           
 [3] "tbodyacc_mean_x"                     "tbodyacc_mean_y"                    
 [5] "tbodyacc_mean_z"                     "tbodyacc_std_x"                     
 [7] "tbodyacc_std_y"                      "tbodyacc_std_z"                     
 [9] "tgravityacc_mean_x"                  "tgravityacc_mean_y"                 
[11] "tgravityacc_mean_z"                  "tgravityacc_std_x"                  
[13] "tgravityacc_std_y"                   "tgravityacc_std_z"                  
[15] "tbodyaccjerk_mean_x"                 "tbodyaccjerk_mean_y"                
[17] "tbodyaccjerk_mean_z"                 "tbodyaccjerk_std_x"                 
[19] "tbodyaccjerk_std_y"                  "tbodyaccjerk_std_z"                 
[21] "tbodygyro_mean_x"                    "tbodygyro_mean_y"                   
[23] "tbodygyro_mean_z"                    "tbodygyro_std_x"                    
[25] "tbodygyro_std_y"                     "tbodygyro_std_z"                    
[27] "tbodygyrojerk_mean_x"                "tbodygyrojerk_mean_y"               
[29] "tbodygyrojerk_mean_z"                "tbodygyrojerk_std_x"                
[31] "tbodygyrojerk_std_y"                 "tbodygyrojerk_std_z"                
[33] "tbodyaccmag_mean"                    "tbodyaccmag_std"                    
[35] "tgravityaccmag_mean"                 "tgravityaccmag_std"                 
[37] "tbodyaccjerkmag_mean"                "tbodyaccjerkmag_std"                
[39] "tbodygyromag_mean"                   "tbodygyromag_std"                   
[41] "tbodygyrojerkmag_mean"               "tbodygyrojerkmag_std"               
[43] "fbodyacc_mean_x"                     "fbodyacc_mean_y"                    
[45] "fbodyacc_mean_z"                     "fbodyacc_std_x"                     
[47] "fbodyacc_std_y"                      "fbodyacc_std_z"                     
[49] "fbodyacc_meanfreq_x"                 "fbodyacc_meanfreq_y"                
[51] "fbodyacc_meanfreq_z"                 "fbodyaccjerk_mean_x"                
[53] "fbodyaccjerk_mean_y"                 "fbodyaccjerk_mean_z"                
[55] "fbodyaccjerk_std_x"                  "fbodyaccjerk_std_y"                 
[57] "fbodyaccjerk_std_z"                  "fbodyaccjerk_meanfreq_x"            
[59] "fbodyaccjerk_meanfreq_y"             "fbodyaccjerk_meanfreq_z"            
[61] "fbodygyro_mean_x"                    "fbodygyro_mean_y"                   
[63] "fbodygyro_mean_z"                    "fbodygyro_std_x"                    
[65] "fbodygyro_std_y"                     "fbodygyro_std_z"                    
[67] "fbodygyro_meanfreq_x"                "fbodygyro_meanfreq_y"               
[69] "fbodygyro_meanfreq_z"                "fbodyaccmag_mean"                   
[71] "fbodyaccmag_std"                     "fbodyaccmag_meanfreq"               
[73] "fbodybodyaccjerkmag_mean"            "fbodybodyaccjerkmag_std"            
[75] "fbodybodyaccjerkmag_meanfreq"        "fbodybodygyromag_mean"              
[77] "fbodybodygyromag_std"                "fbodybodygyromag_meanfreq"          
[79] "fbodybodygyrojerkmag_mean"           "fbodybodygyrojerkmag_std"           
[81] "fbodybodygyrojerkmag_meanfreq"       "angle_tbodyaccmean_gravity"         
[83] "angle_tbodyaccjerkmean__gravitymean" "angle_tbodygyromean_gravitymean"    
[85] "angle_tbodygyrojerkmean_gravitymean" "angle_x_gravitymean"                
[87] "angle_y_gravitymean"                 "angle_z_gravitymean"
