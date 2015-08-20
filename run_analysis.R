require(utils)


##read subject files
subject_test <- read.table("./test/subject_test.txt", header=FALSE, col.names=c("Subject.ID"))
subject_train <- read.table("./train/subject_train.txt", header=FALSE, col.names=c("Subject.ID"))

##read labels file 
y_test <- read.table("./test/y_test.txt", header=FALSE, col.names=c("Activity"))
y_train <- read.table("./train/y_train.txt", header=FALSE, col.names=c("Activity"))

##read features file
features <- read.table("./features.txt", header=FALSE, as.is=TRUE, col.names=c("Feature.ID", "Feature.Name"))

##read data set 
x_test <- read.table("./test/X_test.txt", header=FALSE, sep="", col.names=features$Feature.Name)
x_train <- read.table("./train/X_train.txt", header=FALSE, sep="", col.names=features$Feature.Name)


##2. extract only mean and standard deviation

mean_std <- grep(".*mean\\(\\)|.*std\\(\\)", features$Feature.Name)

x_test <- x_test[, mean_std]
x_train <- x_train[, mean_std]


##add subject ID labels to data set
x_test$Subject.ID <- subject_test$Subject.ID
x_train$Subject.ID <- subject_train$Subject.ID

##add activity labels to data set
x_test$Activity <- y_test$Activity
x_train$Activity <- y_train$Activity


##1. merge test and training data sets

x_data <- rbind(x_test, x_train)



##3. use descriptive activity names
activity_labels <- read.table("./activity_labels.txt", header=FALSE, col.names=c("Activity", "Activity.Name"))

activity_labels$Activity.Name <- as.factor(activity_labels$Activity.Name)



##4.label the data set with descriptive activity names

x_data$Activity <- factor(x_data$Activity, levels = 1:6, labels = activity_labels$Activity.Name)

##transform column names 
column_names <- colnames(x_data)

column_names <- gsub("\\.+mean\\.+", column_names, replacement="Mean")
column_names <- gsub("\\.+std\\.+", column_names, replacement="Std")
column_names <- gsub("Mag", column_names, replacement="Magnitude")
column_names <- gsub("Acc", column_names, replacement="Accelerometer")
column_names <- gsub("Gyro", column_names, replacement="Gyroscope")


##update column names in file
colnames(x_data) <- column_names



##5.create a second, independent tidy data set 
library(reshape2)

melt_data <- melt(x_data, id.vars = c("Subject.ID", "Activity"))
all_data <- dcast(melt_data, Subject.ID + Activity ~ variable, mean)

##write tidy data set
write.table(all_data, "tidydata.txt", row.names = TRUE)