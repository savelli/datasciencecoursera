#########################################################################
# STEP 1 : Merge the training and the test sets to create one data set  #
#########################################################################
# open the X_test file
filename <- "X_test.txt"
xtest <- read.csv(filename, sep="",header = FALSE)
# open the X_train file
filename <- "X_train.txt"
xtrain <- read.csv(filename, sep="",header = FALSE)
# now merge the test and training sets
merged_dataset <- rbind(xtest, xtrain)

#########################################################################
# STEP 2 : Extract only the measurements on the mean and                #
#          standard deviation for each measurement                      #
#########################################################################
# the extracted features are those wich contain the pattern "mean" or "std"
# parse the features file
feat <- read.csv("features.txt", sep="",header = FALSE)
# select the indexes to keep (features that contain mean or std in their label)
to_keep <- grep("*mean*|*std*",feat[,2])
# reduced features table: keep only those rows where the words "mean" and "std" are present
reduced=merged_dataset[,to_keep]

#########################################################################
# STEP 3 : Use descriptive activity names to name the activities in     #
# the data set                                                          #
#########################################################################
# open the activities corresponding to the rows of the test file
test_activities <- read.table("y_test.txt",header = FALSE)
# open the activities corresponding to the rows of the test file
train_activities <- read.table("y_train.txt",header = FALSE)
merged_activities <- rbind(test_activities , train_activities )
# parse the activity labels file
activity_labels <- read.table("activity_labels.txt",header = FALSE)
# replace the activity IDs by their labels and add them in the data set (1st column)
dataset <- cbind(activity_labels[merged_activities[,1],2],reduced)

#########################################################################
# STEP 4 : Appropriately label the data set with descriptive variable   #
# names
#########################################################################
colnames(dataset)[1]<-"activity"
colnames(dataset)[2:80]<-as.vector(feat[to_keep,2])

#########################################################################
# STEP 5 : From the data set in step 4, creates a second, independent   #
# tidy data set with the average of each variable for each activity     #
# and each subject.                                                     #
#########################################################################
# open the subjects corresponding to the rows of the test file
test_subjects <- read.table("subject_test.txt",header = FALSE)
# open the subjects corresponding to the rows of the train file
train_subjects <- read.table("subject_train.txt",header = FALSE)
# merge the 2
merged_subjects <- rbind(test_subjects , train_subjects)
colnames(merged_subjects)<-"subject"
# create a table with subject, activity, and the features columns
df<-cbind(merged_subjects,dataset)
# group by subject, activity and calculate mean on features
# this results in 180 lines (6 activity x 30 subjects)
library(dplyr)
res <- df %>% group_by(subject,activity) %>% summarise_each(funs(mean))
# save the result
res <- apply(res, 2, format) # to align the colummns on the same format
filename <- "tidy-dataset.txt"
write.table(res, filename,row.names = FALSE)