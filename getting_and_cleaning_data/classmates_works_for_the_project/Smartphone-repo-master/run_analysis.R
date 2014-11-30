#
# Götz Ommerborn, November, 23th 2014.
#
# This program creates data set components ready for assembly to a data product which improves maintenance as it allows to easily 
# add future data components to the data set. Therefore, this program does not create the so called "one data set" 
# already in the first step (1) of the assignment, but this creation process is splitted over multiple procedures.

# Throughout the code, comments marked with "##A" refer the steps as indicated by the assignment (see also  readme)
# These ##A comments are not needed to understand the program but are merely added to show how the program
# relates the assignment.

# a) Initialise

        print("Working .....")
        # adapt working directory, if appropriate
        setwd("D:/Users/GOMMERBORN/datasciencecoursera/Smartphone") 
        library(data.table)

# b) Get source data

        ##A Merge the training and the test sets to create one data set
        
        # b.1) Measurements of variables
        x_train <- read.table("x_train.txt")
        x_test <- read.table("x_test.txt")
        
        # b.2) Activities
        y_train <- read.table("y_train.txt")
        y_test <- read.table("y_test.txt")
        
        # b.3) Subjects
        subject_train <- read.table("subject_train.txt")
        subject_test <- read.table("subject_test.txt")

        # b.4) activity names
        activity_names <- read.table("activity_labels.txt")
        
# c)    Compile source data components

        # b.1) Measurements of variables
        
        ##A Merge the training and the test sets to create one data set
        x_total <- rbind(x_train, x_test) 
        
        ##A Extract the measurements on the mean and standard deviation for each measurement
        
        
        # Variables that represent a real mean or std typically contain the string "-mean" or "-std" in the variable name.
        all_variables <- read.table("features.txt")
        mean_std_variables <- all_variables[grep("-mean|:-std", all_variables[, 2]),]
        mean_std_subset <- x_total[,mean_std_variables[,1]]

        ##A Appropriately label the data set with descriptive variable names
        
        # Take the original variable names and add the term "mean of" to indicate that the mean of the original variabled are
        # calculated.
        colnames(mean_std_subset) <- paste("mean-of-", mean_std_variables[,2], sep="")
        
        # b.2) Activities

        ##A Merge the training and the test sets to create one data set
        
        y_total <- rbind(y_train, y_test)

        ##A Apply descriptive activity names to name the activities in the data set.
        
        y_total[, 1] <- activity_names[y_total[, 1], 2] 
        # This replace the id's in the y-total column (assessed by [,1]) with the corresponding 
        # activity description in activity labels table (assessed by [,2])
                # y_total       activity_names
                #       1       1            WALKING
                #       2       2   WALKING_UPSTAIRS
                #       3       3 WALKING_DOWNSTAIRS

        colnames(y_total) <- "activity"
        
        # b.3) Subjects (persons)

        ##A Merge the training and the test sets to create one data set
        
        subject_total <- rbind(subject_train, subject_test)

        colnames(subject_total) <- "subject"

# c)    Assemble source data components to one source data set        

        ## Merge the training and the test sets to create one data set
        
        data_set <- cbind(y_total, subject_total, mean_std_subset)
        
# d)    Create data product
        
        ##A Create a second, independent tidy data set with the average of each variable for each activity and each subject.

        dt_data_set <- data.table(data_set)
        mean_dt_data_set <- dt_data_set[,lapply(.SD, function(x) mean(x)), by=list(activity, subject)]
        # The abovce .SD parameter dynamically taked the columns of the data table which are not included in the "by" parameter".
        # So it calculates the mean of all the variables in the data set.
        
        # Order the set on activity and subject.
        mean_dt_data_set <- mean_dt_data_set[order(mean_dt_data_set$activity, mean_dt_data_set$subject, decreasing=FALSE), ]   
        
# 5)    Output
        
        ##A Output data product with txt file created with write.table() using row.name=FALSE
        
        write.table(mean_dt_data_set, "mean_dt_data_set.txt", row.name=FALSE)
        
# 6)    Close
        print("Finished, file (mean_dt_data_set.txt) written to working directory")