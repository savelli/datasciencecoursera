The run_analysis.R script performs the following steps:

 **1. Merge the training and the test sets to create one data set**
The test and train files (X_test.txt and X_train.txt) are opened and stored in data frames. The 2 dataframes are then merged into 1 single data frames (called merged_dataset) by concatenating the rows.

 **2. Extract only the measurements on the mean and standard deviation for each measurement**
 From the merged dataset, some columns are dropped to create the reduced dataframe. The columns which are those that correspond to features that contain the pattern "mean" or "std" in their labels.
 A regular exression is used to list the column index that contain these 2 words.
 
 **3. Use descriptive activity names to name the activities in the data se**
	 The activity files for the train and test data are opened and the data are merged into a dataframe (by concatenating the rows). This data frame is merged with the data set from the previous step, as an additional column (1st column). The activity_labels.txt file is opened to store the activity labels and corresponding activity codes in a table. This table is used to replace the activity codes in the data set. The resulting data frame is named "dataset".
 
 **4. Appropriately label the data set with descriptive variable names**
Column labels are renamed so that the first column label is "activity", and the subsequent columns are named after the corresponding features (the list of features that were extracted in step 2).

 **5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.** 
 The subject files are opened and added as the 1st column of the dataset. Then, the dplyr module is used to group the rows by subect and activity, and to perform the mean() on the features columns.
This results in a 180 lines data set (6 activity x 30 subjects), called res.

Note that the input data files shall be located in the same directory as the run_analysis.R scrit.
This includes the following files: X_test.txt, X_train.txt, features.txt, y_test.txt, y_train.txt, activity_labels.txt, subject_test.txt, subject_train.txt