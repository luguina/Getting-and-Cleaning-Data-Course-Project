Getting-and-Cleaning-Data-Course-Project
========================================

This readme file explains how all of the scripts work in order to prepare tidy data from a raw data set of _Human Activity Recognition Using Smartphones_. The goal of this script is to create a data set that can be used for later analysis.  

This script should be able to use the data from this [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and:
1. Merge the training and the test sets to create one data set, extracting only the measurements on the mean and standard deviation for each measurement. 
2. Use descriptive activity names to name the activities in the data set
3. Appropriately label the data set with descriptive variable names. 
4. creates a second, independent tidy data from the result of 1+2+3 and set with the average of each variable for each activity and each subject.
  
**Note:** This script can be run as long as the original data sets are in the R working directory. A full description is available at this [site](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
  
### How this script works  
  
The script starts creating a vector that will hold the _training_ and the _test_ sets. This is done in the `mergeDatasets` function at the beginning of the script.

```
   ## Merge the test and train data sets
   dt.signals <- mergeDatasets()
```
  
The `mergeDatasets` function first initializes the vector to 561 NULL values (the number of variables in the original data sets) and then sets the cols that we will extract (this way we'll only extract the mean and standard deviation columns from the original data set as requested in the project).

```
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
```

The next step is to load and merge the _test_ and _training_ data sets. 

It exists three files for each data set:
* `subject_<set>.txt`: stores the identifier of the subject who carried out the experiment
* `y_<set>.txt`: stores the identifier of the activity
* `X_<set>.txt`: stores the different measurements

**Note:** The `<set>` identifier will be either _test_ or _train_ if we refer to the _test_ or _training_ data sets respectively.

As the three files contains the correspondent measures line by line, we can use the `cbind` function to merge all the data sets in one single step.

```
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
```

Note that when importing the `X_<set>.txt` we specify the `colClasses` parameter with the `colsToExtract` vector to only retrieve the necessary columns from the file. 

Once we've merged the _test_ data sets, will do the same with _training_ ones and the  `mergeDatasets` function will finally return the merge of _test_ and _training_ data sets.

Next step is to appropriately label the full data set with descriptive variable names (the first two: SubjectID and Activity have been set in the import process).

```
   ## Change columns names   
   setnames( dt.signals,  3, "tBodyAccMean-X" )
   setnames( dt.signals,  4, "tBodyAccMean-Y" )
   setnames( dt.signals,  5, "tBodyAccMean-Z" )
   setnames( dt.signals,  6, "tBodyAccStd-X" )
   setnames( dt.signals,  7, "tBodyAccStd-Y" )
   ...
```

Next step will be using descriptive activity names to name the activities in the data set. We do it with the following code:

```
   dt.signals[Activity==1, Activity:="WALKING"]
   dt.signals[Activity==2, Activity:="WALKING_UPSTAIRS"]
   dt.signals[Activity==3, Activity:="WALKING_DOWNSTAIRS"]
   dt.signals[Activity==4, Activity:="SITTING"]
   dt.signals[Activity==5, Activity:="STANDING"]
   dt.signals[Activity==6, Activity:="LAYING"]
```

And finally with the beautified data set we create a second, independent tidy data set with the average of each variable for each activity and each subject and write it in the default directory.

```
   dt.tidy <- dt.signals[,lapply( .SD, mean ), by=c( "SubjectID", "Activity" )]
   
   write.table( dt.tidy, "tidy_dataset.txt", row.names=FALSE )
```

