## 1. Merge the training and the test sets to create one data set:
#Read txt files for test and train data sets
x_test <- read.table ("X_test.txt"); x_train <- read.table ("X_train.txt")
#Combine test and train data sets by row into a single data frame
x_set <- rbind(x_test, x_train) 
        
#Read txt files for test and train labels 
test_label <- read.table ("y_test.txt"); train_label <- read.table ("y_train.txt")
#Combine test and train labels by row into a single data frame 
label <- rbind(test_label, train_label) 
            
#Read txt files for test and train subject ID's and rename V1 column 
sub_test <- read.table ("subject_test.txt",col.names=c("Subject")); sub_train <- read.table ("subject_train.txt",col.names=c("Subject"))
#Combine test and train subject ID's by row into a single data frame
subject <- rbind(sub_test, sub_train) 
          
## 2. Extract only the measurements on the mean and standard deviation for each measurement:
#Read txt file for features labels and rename V1 & V2 columns
features <- read.table ("features.txt",stringsAsFactors=FALSE, col.names=c("index", "feature_label"))

#Create vector that contains just the label column from the "features" data frame
label <- features$feature_label
#Add labels to x_set data frame before subsetting
colnames(x_set) <- label        
#Add logical vector to label data frame indicating columns which have mean() and std() in their name
features_subset <- grepl('mean\\(\\)|std\\(\\)',label)
#Create a character vector of only features with mean and standard deviation in their name
features <- as.character(label[features_subset]) 
#Extract only mean and std columns from x_set using the logical vector "features_subset"
x_set <- x_set[,features_subset]
                
## 3.Uses descriptive activity names to name the activities in the data set
colnames(label) <- "activity_code"
#Read txt files for activity labels
activity_labels <- read.table ("activity_labels.txt", col.names=c("activity_code", "Activity"))
#Add activity descriptions to activity where "activity_code" is the same in label file
activities_desc <- join(label,activity_labels, by = "activity_code")
activities_desc$activity_code <- NULL

#Combine test/train data set (x_set) with activity (activity_desc) and subject ID (subject)
all_data <- cbind(x_set, activities_desc, subject)
                 
##5.From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
library(reshape2)
#Melt data frame for reshaping
td <- melt(all_data, id=c("Subject", "Activity"),measure.vars=features)
#Reshape into tidy data frame by mean
td <- dcast(td, Subject + Activity ~ variable, mean)
#Reorder by Subject, Activity
td <- td[order(td$Subject, td$Activity),]

##4.Appropriately label the data set with descriptive variable names.
names <- names(td)
names <- gsub('-mean', 'Mean', names) # Replace `-mean' by `Mean'
names <- gsub('-std', 'Std', names) # Replace `-std' by 'Std'
names <- gsub('[()-]', '', names) # Remove the parenthesis and dashes
names <- gsub('BodyBody', 'Body', names) # Replace `BodyBody' by `Body'
setnames(td, names)

#Write output file
write.table(td,file="tidy_dataset.txt", row.names = FALSE) 
