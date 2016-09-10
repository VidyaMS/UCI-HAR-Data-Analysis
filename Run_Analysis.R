## Run_Analysis Script to read Human Activity Recognition data , extract the required values , and perform aggregation to understand the required values.

## Step 1 - Read UCI HAR Data set into R .
## Subject_train , x_train and y_train . x_train contains the training data set  to be analysed and y_train contains the corresponding activity labels. 
## Subject_train contains the corresponding subjects (1 to 30) for each record in x_train. 

	subject_train <- read.table("subject_train.txt", header = FALSE , sep = "" , col.names = "Subject" )

	x_train <- read.table("X_train.txt", header = FALSE , sep = "" )

	y_train <- read.table("y_train.txt", header = FALSE , sep = "" , col.names = "Activity" )

## Subject_test , x_test and y_test . x_test contains the testing  data to be analysed and y_test contains the corresponding activity labels. 
## Subject_test contains the corresponding subjects (1 to 30) for each record in x_test. 


	subject_test <- read.table("subject_test.txt", header = FALSE ,col.names = "Subject", sep = "" )

	x_test <- read.table("X_test.txt", header = FALSE , sep = "" )

	y_test <- read.table("y_test.txt", header = FALSE , sep = "" , col.names = "Activity" )

## Features file contains the 561 feature vector that describes each row of train and test data . 


	features <- read.table("features.txt", header = FALSE , sep = "" )

	library(plyr)

## Bind together the activity labels data to train and test data .

	Activity_Train <- cbind(x_train,y_train)

	Activity_Test <- cbind(x_test,y_test)

## Bind together the subject data  to train and test data whch contains activity labels too .


	Total_Test <- cbind(Activity_Test, subject_test)

	Total_Train <- cbind(Activity_Train, subject_train)

## Combine toether the training and test data 

	Entire_Data <- rbind(Total_Train, Total_Test)

## Provide the descriptive labels for the activity. This info is provided "activity_labels.txt" file. 

	Entire_Data$Activity <- factor(Entire_Data$Activity , levels = c("1","2","3","4","5","6"),labels = c("Walking", "Walking_Upstairs","Walking_Downstairs","Sitting","Standing","Laying"))
	
	library(dplyr)

	Entire_Data_Tbl <- tbl_df(Entire_Data)

## Extracting the required info from the Entire data set 
## Extracting the measurements for mean and standard deviation variables. "Features.txt" file provides the names of the variables. 

## Find the variable names for extraction with in the 561 feature  .
	Mean_Std  <- grep("mean|std", features$V2 )

## Using select() , create a data set with the required variables.  
	Mean_Std_Data <- select(Entire_Data_Tbl , V1:V6 , V41:V46, V81:V86 , V121:V126 , V161:V166 , V201,V202 ,V214 ,V215 , V227 ,V228, V240 ,V241 , V253 , V254, V266:V271 , V294:V296 ,V345:V350 , V373:V375,
	 V424:V429 , V452:V454 , V503, V504 , V513, V516 ,V517,  V526 , V529 , V530 , V539 , V542 , V543, V552 , Activity , Subject) 

## Rename the variables with the appropriate description.

	Mean_Std_Data <- rename(Mean_Std_Data ,tBodyAccMeanX = V1,tBodyAccMeanY = V2 ,tBodyAccMeanZ = V3, tBodyAccStdX = V4,tBodyAccStdY = V5 ,tBodyAccStdZ = V6,tBodyGrvMeanX = V41 ,tBodyGrvMeanY = V42 ,tBodyGrvMeanZ = V43, tBodyGrvStdX = V44,tBodyGrvStdY = V45 ,tBodyGrvStdZ = V46,
	tBodyAccJrkMeanX = V81 ,tBodyAccJrkMeanY = V82 ,tBodyAccJrkMeanZ = V83, tBodyAccJrkStdX = V84,tBodyAccJrkStdY = V85 ,tBodyAccJrkStdZ = V86 ,tBodyGyroMeanX = V121 ,tBodyGyroMeanY = V122 ,tBodyGyroMeanZ = V123,tBodyGyroStdX = V124,tBodyGyroStdY = V125 ,tBodyGyroStdZ = V126 ,tBodyGyroJrkMeanX = V161 ,tBodyGyroJrkMeanY = V162 ,tBodyGyroJrkMeanZ = V163,tBodyGyroJrkStdX = V164,tBodyGyroJrkStdY = V165 ,tBodyGyroJrkStdZ = V166,
	tBodyAccMagMean = V201 , tBodyAccMagStd = V202 , tGrvAccMagMean = V214, tGrvAccMagStd = V215, tBodyAccJrkMagMean = V227,tBodyAccJerkMagStd = V228, tBodyGyroMagMean = V240, tBodyGyroMagStd = V241,tBodyGyroJerkMagMean = V253 , tBodyGyroJerkMagStd = V254,
	fBodyAccMeanX = V266 ,fBodyAccMeanY = V267,fBodyAccMeanZ = V268,fBodyAccStdX = V269,fBodyAccStdY = V270,fBodyAccStdZ = V271,fBodyAccMeanFreqX = V294 ,fBodyAccMeanFreqY = V295,fBodyAccMeanFreqZ = V296, fBodyAccJerkMeanX = V345,fBodyAccJerkMeanY = V346,fBodyAccJerkMeanZ = V347 ,fBodyAccJerkStdX = V348, fBodyAccJerkStdY = V349, fBodyAccJerkStdZ = V350,
	fBodyAccJerkmeanFrqX = V373 , fBodyAccJerkmeanFrqY = V374, fBodyAccJerkmeanFrqZ = V375, fBodyGyroMeanX = V424 ,fBodyGyroMeanY = V425,fBodyGyroMeanZ = V426,fBodyGyroStdX = V427 ,fBodyGyroStdY = V428,fBodyGyroStdZ = V429,
	fBodyGyroMeanFreqX = V452, fBodyGyroMeanFreqY = V453, fBodyGyroMeanFreqZ = V454, fBodyAccMagMean = V503, fBodyAccMagStd = V504 ,
	fBodyAccMagMeanFreq = V513, fBodyBodyAccJerkMagMean = V516 ,fBodyBodyAccJerkMagStd = V517, fBodyBodyAccJerkMagMeanFreq = V526, fBodyBodyGyroMagMean = V529 , fBodyBodyGyroMagStd = V530,
	fBodyBodyGyroMagMeanFreq = V539, fBodyBodyGyroJerkMagMean = V542, fBodyBodyGyroJerkMagStd = V543,fBodyBodyGyroJerkMagMeanFreq = V552   )	


## Using dplyr package , calculate the average of each measurement grouped by Subject and Activity . 

	Aggregate_Data <- Mean_Std_Data %>% group_by(Subject, Activity) %>% summarise_each(funs(mean)) 

## Create the txt file for uploding the tidy data set containing the required information.
	write.table(Aggregate_Data,row.names = FALSE , file = "UCI_HAR_Aggregate.txt")

	
## THANK YOU! 
