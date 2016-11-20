## cleans the data as required. Each of the five points is covered and there is a comment in the code
## at the location where the item is dealt with. I've done some of the items in a different order
## as the order was only specified between items #4 & 5
run_analysis <- function () {
      
      ## make sue we have all the libs we will need
      packageLoad <- function(x) {
            if (!require(x,character.only = T)) {
                  install.packages(x,dep=T)
                  if(!require(x,character.only = T)) stop(Paste("Package", x, "couldn't be loaded"))
            }
      }
      
      packageLoad("data.table")
      packageLoad("dplyr")
      
      
      ## load the files
      flLabels <- "activity_labels.txt"
      flFeatures <- "features.txt"
      
      dLabels <- read.table(flLabels, sep = "" , header = F)
      dFeatures <- read.table(flFeatures, sep = "", header = F)
      
      ## replace all (), - and , with _ then remove any _ at the ends of the strings using "_$"
      xColNames = gsub("_$", "", gsub("(\\(\\)-?)|[\\(\\)--,]", "_", tolower(dFeatures[[2]])))
      ## need to run this as there are duplicates
      xColNames <- make.names(names=xColNames, unique=T, allow_ = T)
      
      extractDataSet <- function(tstOrTrn) {
            ## load the current data set - use the passed in variable to get the appropriate files
            xData <- data.table::fread(paste0(tstOrTrn, "/X_", tstOrTrn, ".txt"), header=F)
            yData <- data.table::fread(paste0(tstOrTrn, "/y_", tstOrTrn, ".txt"), header=F)
            subjectData <- data.table::fread(paste0(tstOrTrn, "/subject_", tstOrTrn, ".txt"), header=F)
            
            subjectData <- rename(subjectData, subject_id = V1)
            
            ## 4. Appropriately labels the data set with descriptive variable names.
            ## (the names provided by the features file seem to be quite good once tidied up)
            names(xData) <- xColNames
            
            ## 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
            ## this is slightly ambiguous could be restricted to only mean/std functions by  adding 
            ## "(_|$)" into the regular expression
            xData <- select(xData, grep("mean|std", xColNames, ignore.case = T))
            
            
            ## Join it all together assuming that everything is in order (it should be)
            ## this needs to be done before the outer join as that reorders columns
            newData <- bind_cols(subjectData, yData, xData)
            
            ## 3. Uses descriptive activity names to name the activities in the data set
            ## rename the activity column remove the redundatn V1 colum and re-order the columns
            newData <- left_join(newData, dLabels, by="V1") %>%
                  rename(activity = V2) %>% 
                  select(-V1) %>%
                  select(subject_id, activity, 2:(ncol(newData)-1))  
      }
      
      ## 1. Merges the training and the test sets to create one data set.
      ## use the function above to get the tidied data for each item and join them here
      completeSet <- bind_rows(extractDataSet("test"), extractDataSet("train"))

      ## View(completeSet)
      
      ## 5. From the data set in step 4, creates a second, independent tidy data set with
      ## the average of each variable for each activity and each subject.
      summary <- group_by(completeSet, subject_id, activity) %>% summarise_each(funs(mean)) %>% 
            arrange(subject_id, activity)
}