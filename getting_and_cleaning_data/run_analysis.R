library(dplyr)
# merge train and test data sets
x_train = read.table("./UCI HAR Dataset/train/X_train.txt")
x_test = read.table("./UCI HAR Dataset/test/X_test.txt")
data = merge(x_train, x_test, all=TRUE)
data = tbl_df(data)

# select mean and std columns for a new data set data1
features = read.table("~/R-PROJECT/UCI HAR Dataset/features.txt")
number = grep("mean|std", features[,2], perl=TRUE, value=FALSE)
data1 = select(data,number)

# set variable names for data1
features_names = as.vector(features[,2])
features_names1 = features_names[number]
names(data1) = features_names1

# load activity names and transfer them into an array.
activity_labels = read.table("~/R-PROJECT/UCI HAR Dataset/activity_labels.txt")
activity_labels = as.vector(activity_labels[,2])

# merge the data frames fo activity symbol numbers 
train_label = read.table("~/R-PROJECT/UCI HAR Dataset/train/y_train.txt")
test_label = read.table("~/R-PROJECT/UCI HAR Dataset/test/y_test.txt")
label = rbind(train_label, test_label)
head(label)
# add a new column of activity names correspondin to each row's activity symbol number
label = tbl_df(label)
label = mutate(label,Activity_Name = activity_labels[V1])

# load subject NO. and merge them into one column
subject_train = read.table("~/R-PROJECT/UCI HAR Dataset/train/subject_train.txt")
subject_test = read.table("~/R-PROJECT/UCI HAR Dataset/test/subject_test.txt")
subject_no = rbind(subject_train,subject_test)
subject = tbl_df(subject_no)

# merge the second column, i.e. activity names, of label and subject
label = cbind(label[,2],subject)
names(label) <- c("Activity_Name","Subject")
# merge label and data1
data2 = cbind(data1,label)
data2 = tbl_df(data2)
class(data2)
# create a new data set grouped by activity and subject, summarizing the average of each variable
data3 = group_by(data2,Activity_Name,Subject)
# summarize the data set by calculating the average of each variable
data4 = summarise_each(data3,funs(mean))
# output the result
write.table(data4,file="tidydata.txt",row.name = FALSE)
