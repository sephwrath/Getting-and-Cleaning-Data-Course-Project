# Getting-and-Cleaning-Data-Course-Project

## Running the script

The run_analysis.R file contains a single external function run_analysis() which performs the cleanup of the Human Activit Recognition Using Smartphones Data sourced from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script doesn't support any arguments and the two packages (data.table and dplyr) that it depends on are checked for by the script and loaded if they are not present. However it does expect the working directory to be set to the top level folder containing the following files and direcotories as unpacked from the above url.

1. Features.txt
2. Activity Labels.txt
3. Test
4. Train

Below is an example of how to run the script and obtain the cleansed data file.

data<-run_analysis()
write.table(data, "outputData.txt")

To read the output into R again the following commands can be used.

data <- read.table("outputData.txt", header = TRUE) 
View(data)

