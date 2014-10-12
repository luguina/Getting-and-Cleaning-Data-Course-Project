## Coursera's Getting and Cleaning Data
## Course Project
## Due date: Mon 3 Nov 1:30 am GMT+2
##
## Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most 
## advanced algorithms to attract new users. The data linked to from the course 
## website represent data collected from the accelerometers from the Samsung Galaxy 
## S smartphone. A full description is available at the site where the data was 
## obtained: 
## 
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
##
## Here is the data for the project: 
##   
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
##
## This script must do the following actions:
## 
##    1. Merges the training and the test sets to create one data set
##       (but only the measurements on the mean and standard deviation for each 
##       measurement).
##    2. Use descriptive activity names to name the activities in the data set
##    3. Appropriately labels the data set with descriptive variable names. 
##    4. From the data set in step 3, creates a second, independent tidy data set 
##       with the average of each variable for each activity and each subject.
##

## 
## 
## 

run_analysis <- function() {
   ## Load required libraries
   library(data.table)
   
   mergeDatasets <- function() {
      ## Create a vector with only the variables I need to extract from the large
      ## measurements files (X_test.txt & X_train.txt)
      colsToExtract <- rep( "NULL", 561 )
      colsToExtract[c( 1:3,      ## tBodyAcc-mean()-XYZ
                       4:6,      ## tBodyAcc-std()-XYZ
                       41:43,    ## tGravityAcc-mean()-XYZ
                       44:46,    ## tGravityAcc-std()-XYZ
                       81:83,    ## tBodyAccJerk-mean()-XYZ
                       84:86,    ## tBodyAccJerk-std()-XYZ
                       121:123,  ## tBodyGyro-mean()-XYZ
                       124:126,  ## tBodyGyro-std()-XYZ
                       161:163,  ## tBodyGyroJerk-mean()-XYZ
                       164:166,  ## tBodyGyroJerk-std()-XYZ
                       201,      ## tBodyAccMag-mean()
                       202,      ## tBodyAccMag-std()
                       214,      ## tGravityAccMag-mean()
                       215,      ## tGravityAccMag-std()
                       227,      ## tBodyAccJerkMag-mean()
                       228,      ## tBodyAccJerkMag-std()
                       240,      ## tBodyGyroMag-mean()
                       241,      ## tBodyGyroMag-std()
                       253,      ## tBodyGyroJerkMag-mean()
                       254,      ## tBodyGyroJerkMag-std()
                       266:268,  ## fBodyAcc-mean()-XYZ
                       269:271,  ## fBodyAcc-std()-XYZ
                       345:347,  ## fBodyAccJerk-mean()-XYZ
                       348:350,  ## fBodyAccJerk-std()-XYZ
                       424:426,  ## fBodyGyro-mean()-XYZ
                       427:429,  ## fBodyGyro-std()-XYZ
                       503,      ## fBodyAccMag-mean()
                       504,      ## fBodyAccMag-std()
                       516,      ## fBodyBodyAccJerkMag-mean()
                       517,      ## fBodyBodyAccJerkMag-std()
                       529,      ## fBodyBodyGyroMag-mean()
                       530,      ## fBodyBodyGyroMag-std()
                       542,      ## fBodyBodyGyroJerkMag-mean()
                       543       ## fBodyBodyGyroJerkMag-std()
                     )] <- "numeric"
      
      ## Read the files and convert to data.table (using this workarround as fread()
      ## function is not working and throws a fatal error in R)
      
      ## Test files set
      dt.testSubject <- data.table(
         read.table( "./UCI HAR Dataset/test/subject_test.txt",
                     col.names="SubjectID" ))
      
      dt.testActivity <- data.table(
         read.table( "./UCI HAR Dataset/test/y_test.txt",
                     col.names="Activity", 
                     colClasses="character" ))
      
      dt.testSignals <- data.table(
         read.table( "./UCI HAR Dataset/test/X_test.txt",
                     colClasses=colsToExtract,
                     comment.char = "" ))

      ## Merge all the test info in one single data table
      dt.testMerged <- cbind( dt.testSubject, dt.testActivity, dt.testSignals )

      ## Train files set
      dt.trainSubject <- data.table(
         read.table( "./UCI HAR Dataset/train/subject_train.txt",
                     col.names="SubjectID" ))
      
      dt.trainActivity <- data.table(
         read.table( "./UCI HAR Dataset/train/y_train.txt",
                     col.names="Activity", 
                     colClasses="character",
                     comment.char = "" ))
      
      dt.trainSignals <- data.table(
         read.table( "./UCI HAR Dataset/train/X_train.txt",
                     colClasses=colsToExtract ))
      
      ## And now merge all the train info in one single data table
      dt.trainMerged <- cbind( dt.trainSubject, dt.trainActivity, dt.trainSignals )
      
      ## Return the sum of both (test + train) tables
      return( rbind( dt.testMerged, dt.trainMerged ))
   }
   
   ## 
   dt.signals <- mergeDatasets()

   ## Change columns names   
   setnames( dt.signals,  3, "tBodyAccMean-X" )
   setnames( dt.signals,  4, "tBodyAccMean-Y" )
   setnames( dt.signals,  5, "tBodyAccMean-Z" )
   setnames( dt.signals,  6, "tBodyAccStd-X" )
   setnames( dt.signals,  7, "tBodyAccStd-Y" )
   setnames( dt.signals,  8, "tBodyAccStd-Z" )
   setnames( dt.signals,  9, "tGravityAccMean-X" )
   setnames( dt.signals, 10, "tGravityAccMean-Y" )
   setnames( dt.signals, 11, "tGravityAccMean-Z" )
   setnames( dt.signals, 12, "tGravityAccStd-X" )
   setnames( dt.signals, 13, "tGravityAccStd-Y" )
   setnames( dt.signals, 14, "tGravityAccStd-Z" )
   setnames( dt.signals, 15, "tBodyAccJerkMean-X" )
   setnames( dt.signals, 16, "tBodyAccJerkMean-Y" )
   setnames( dt.signals, 17, "tBodyAccJerkMean-Z" )
   setnames( dt.signals, 18, "tBodyAccJerkStd-X" )
   setnames( dt.signals, 19, "tBodyAccJerkStd-Y" )
   setnames( dt.signals, 20, "tBodyAccJerkStd-Z" )
   setnames( dt.signals, 21, "tBodyGyroMean-X" )
   setnames( dt.signals, 22, "tBodyGyroMean-Y" )
   setnames( dt.signals, 23, "tBodyGyroMean-Z" )
   setnames( dt.signals, 24, "tBodyGyroStd-X" )
   setnames( dt.signals, 25, "tBodyGyroStd-Y" )
   setnames( dt.signals, 26, "tBodyGyroStd-Z" )
   setnames( dt.signals, 27, "tBodyGyroJerkMean-X" )
   setnames( dt.signals, 28, "tBodyGyroJerkMean-Y" )
   setnames( dt.signals, 29, "tBodyGyroJerkMean-Z" )
   setnames( dt.signals, 30, "tBodyGyroJerkStd-X" )
   setnames( dt.signals, 31, "tBodyGyroJerkStd-Y" )
   setnames( dt.signals, 32, "tBodyGyroJerkStd-Z" )
   setnames( dt.signals, 33, "tBodyAccMagMean" )
   setnames( dt.signals, 34, "tBodyAccMagStd" )
   setnames( dt.signals, 35, "tGravityAccMagMean" )
   setnames( dt.signals, 36, "tGravityAccMagStd" )
   setnames( dt.signals, 37, "tBodyAccJerkMagMean" )
   setnames( dt.signals, 38, "tBodyAccJerkMagStd" )
   setnames( dt.signals, 39, "tBodyGyroMagMean" )
   setnames( dt.signals, 40, "tBodyGyroMagStd" )
   setnames( dt.signals, 41, "tBodyGyroJerkMagMean" )
   setnames( dt.signals, 42, "tBodyGyroJerkMagStd" )
   setnames( dt.signals, 43, "fBodyAccMean-X" )
   setnames( dt.signals, 44, "fBodyAccMean-Y" )
   setnames( dt.signals, 45, "fBodyAccMean-Z" )
   setnames( dt.signals, 46, "fBodyAccStd-X" )
   setnames( dt.signals, 47, "fBodyAccStd-Y" )
   setnames( dt.signals, 48, "fBodyAccStd-Z" )
   setnames( dt.signals, 49, "fBodyAccJerkMean-X" )
   setnames( dt.signals, 50, "fBodyAccJerkMean-Y" )
   setnames( dt.signals, 51, "fBodyAccJerkMean-Z" )
   setnames( dt.signals, 52, "fBodyAccJerkStd-X" )
   setnames( dt.signals, 53, "fBodyAccJerkStd-Y" )
   setnames( dt.signals, 54, "fBodyAccJerkStd-Z" )
   setnames( dt.signals, 55, "fBodyGyroMean-X" )
   setnames( dt.signals, 56, "fBodyGyroMean-Y" )
   setnames( dt.signals, 57, "fBodyGyroMean-Z" )
   setnames( dt.signals, 58, "fBodyGyroStd-X" )
   setnames( dt.signals, 59, "fBodyGyroStd-Y" )
   setnames( dt.signals, 60, "fBodyGyroStd-Z" )
   setnames( dt.signals, 61, "fBodyAccMagMean" )
   setnames( dt.signals, 62, "fBodyAccMagStd" )
   setnames( dt.signals, 63, "fBodyBodyAccJerkMagMean" )
   setnames( dt.signals, 64, "fBodyBodyAccJerkMagStd" )
   setnames( dt.signals, 65, "fBodyBodyGyroMagMean" )
   setnames( dt.signals, 66, "fBodyBodyGyroMagStd" )
   setnames( dt.signals, 67, "fBodyBodyGyroJerkMagMain" )
   setnames( dt.signals, 68, "fBodyBodyGyroJerkMagStd" )
   
   dt.signals[Activity==1, Activity:="WALKING"]
   dt.signals[Activity==2, Activity:="WALKING_UPSTAIRS"]
   dt.signals[Activity==3, Activity:="WALKING_DOWNSTAIRS"]
   dt.signals[Activity==4, Activity:="SITTING"]
   dt.signals[Activity==5, Activity:="STANDING"]
   dt.signals[Activity==6, Activity:="LAYING"]
   
   dt.tidy <- dt.signals[,lapply( .SD, mean ), by=c( "SubjectID", "Activity" )]
   
   write.table( dt.tidy, "tidy_dataset.txt", row.names=FALSE )
   
   return( dt.tidy )
}