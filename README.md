# Getting-and-Cleaning-Data-Course-Project
Getting and Cleaning Data Course Project


To run the script and obtain the cleansed data file.

data<-run_analysis()
write.table(data, "outputData.txt")

To read the output into R again the following commands can be used.

data <- read.table("outputData.txt", header = TRUE) 
View(data)

