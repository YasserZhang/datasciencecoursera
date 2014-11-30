run_analysis<-function()
{
    ## SCRIPT FOR FINAL PROJECT OF GETTING A CLEANNING DATA
    ## 1.- Merges the training and the test sets to create one data set.
    ##
        library(dplyr)
        if(!file.exists("./UCI HAR Dataset")){
            stop("You should had set the working directory in where is the file Directory: /UCI HAR Dataset")
        }
        arch_nomcol<-paste(getwd(),"/UCI HAR Dataset/features.txt",sep="")
        table_nom<-read.csv(arch_nomcol,sep=" ",header=FALSE,colClasses="character")
        x<-leer_datos("test")  ## Read for test files 
        y<-leer_datos("train") ## Read for train files
        todos<-rbind(x,y)
    ##
    ##2.- Extracts only the measurements on the mean and standard deviation
    ##    for each measurement. I exclude the variables with angle because this is not a mean.
    ##
        only_select_col<-select(todos,Subject,Activity,contains("mean"), contains("std"),-contains("angle"))
    ##
    ##3.- Uses descriptive activity names to name the activities in the data set
    ##
        arch_activities<-paste(getwd(),"/UCI HAR Dataset/activity_labels.txt",sep="")
        nom_activities<-read.table(arch_activities,colClasses="character")
        with_names_act<-mutate(only_select_col,Activity=nom_activities[Activity,2])
    ##
    ##4.-Appropriately labels the data set with descriptive variable names.
    ##   This step I will correct the characters of column names 
    ##
        c_names<-colnames(with_names_act)
        c_names<-sub("...",as.character("_"),c_names,fixed=TRUE)
        c_names<-sub("..",as.character(""),c_names,fixed=TRUE) 
        c_names<-sub(".",as.character("_"),c_names,fixed=TRUE) 
    ## because only fixed the first one I need to do it one more time
        c_names<-sub(".",as.character("_"),c_names,fixed=TRUE)
        colnames(with_names_act)<-c_names
    ##
    ##5.-From the data set in step 4, creates a second, independent tidy data set with
    ##   the average of each variable for each activity and each subject.
    ##    
        Archivo<-with_names_act%>%group_by(Activity,Subject)%>%summarise_each(funs(mean))
        write.table(Archivo,file="get&clean.txt",row.name=FALSE)
        return(Archivo)
}
leer_datos<-function(cual="test")
{ 
    ## definitions off names of tables to be read
    ##
    arch_res<-paste(getwd(),"/UCI HAR Dataset/",cual,"/X_",cual,".txt",sep="")
    arch_suj<-paste(getwd(),"/UCI HAR Dataset/",cual,"/subject_",cual,".txt",sep="")
    arch_act<-paste(getwd(),"/UCI HAR Dataset/",cual,"/y_",cual,".txt",sep="")
    arch_nomcol<-paste(getwd(),"/UCI HAR Dataset/features.txt",sep="")
    if(!file.exists(arch_suj) | !file.exists(arch_res) | !file.exists(arch_act) | !file.exists(arch_nomcol)){
        stop("Please verify that every file is in the original position and name")
    }
    ##
    ## reading tables and renames the column names
    ##
    table_nom<-read.csv(arch_nomcol,sep=" ",header=FALSE,colClasses="character")    
    table_test<-read.table(arch_res,col.name=table_nom[,2])
    table_subject<-read.table(arch_suj)
    colnames(table_subject)<-c("Subject")
    table_activity<-read.table(arch_act)
    colnames(table_activity)<-c("Activity")
    ##
    ## merge de tables by column
    ##
    return(cbind(table_activity,table_subject,table_test))
}