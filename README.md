Getting-and-Cleaning-Data-Course-Project
========================================

This readme file explains how all of the scripts work in order to prepare tidy data from a raw data set of _Human Activity Recognition Using Smartphones_. The goal of this script is to create a data set that can be used for later analysis.  
  
*Note:* This script can be run as long as the original data sets are in the R working directory  
  
### How this script works  
  
The first part of the script creates a vector that will hold the required variables as we will only extract the mean and standard deviation measurements.  
  
We first initialize the vector to 561 NULL values and then define the cols that we will stract (this way we'll only extract the defined columns in the original data set).  

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

