# UCI-HAR-Data-Analysis

Files needed to be present in the directory :
1. features.txt
2. activity_labels.txt
3. Data - x_train and x_test
4. Activity label data - y_train and y_test 
5. Subject data - subject_train and subject_test.

Background of the UCI HAR experiment :
30 Subjects  were particpating in the experiment by performing activities of daily living (ADL) - (Walking, Walking_Upstairs,Walking_Downstairs, Sitting, Standing , Laying) with a Samsung Smartphone waist-mounted and having inertial sensors .
The sensor signals were captured , and processed and made available as a 561 feature vector . The details are available in the features.txt file and description is provided in features_info.txt file.
The data is split into training and test data sets . 

Run_Analysis. R :

The script performs the following :

1. Read the data UCI HAR data set (described above) into R.
2. Combine the activity labels and subject data with the main data in x_train and x_test . (R object - Activity_Test,Activity_Train,Total_Train,Total_Test.) 
3. Then combine the Total_Train and Total_test data into a complete data set .( R object - Entire_Data)
4. Need to extract the variables which provide the mean and standard deviation measurements . So recognise those variables from the feature list . Create a data set with the required data (R Object - Mean_Std_Data )
5. Using rename() , provide the descriptive names of the variables.
6. Create the activity labels as factor variable and provide the labels of the activity.
7. Using dplyr package , group by the data by Subject and Activity and calculate the average of each of the measurement.( R object - Aggregate_Data) 
8. Write the file as a txt file so that it can be uploaded.
