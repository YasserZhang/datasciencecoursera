### ASSIGNMENT

The assignment requires the below to be done:

*Create one R script called run_analysis.R that does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable For each activity and each subject.* 

and

*6. to upload your data set as a txt file, created with write.table() using row.name=FALSE.*
       
### ASSUMPTION
The above task list indicates what needs to be done, and does not necessarily represent a programme structure. See also coursera data science thread https://class.coursera.org/getdata-009/forum/thread?thread_id=58. David HoodCommunity TA: 

*The really important bit is 5 has to come after the rest, because you are getting the data ready for 5 from the earlier section. The order of 2-4 isn't too critical. For example if you are using dply you pretty much have to do some fixing up on the variable names early on or it is going to complain about the duplicate names. If you are selecting out the columns with grep, you could (in theory) do the selecting out then fix up the names later on. But providing everything is sorted out by the end of 4 I wouldn't be worried.*

### DATA STRUCTURE

Source data comprises: the files x-train, x-test, y-train, y-test, subject-train, subject-test, activity-labels, features.
 
The data delivered by UCI (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) is separated by data to train a to-be statistical model and by data to test this to-be statistical model. The R script developed uses the below data files from above data set:

* X data files (train and test) contain the measurements, represented by variables, combined in occurrences (rows).
* y data files (train and test) contain the activity id's for each measurement.
* Subject data files (train and test) contain the person id's for each measurement; these are the persons who's smartphone recorded the measures. 
* Activity labels data file contains the activity labels matching with the y data file activity id's
* Features data file contains the list of variables for measurements were taken.

### SOLUTION

Key for the solution is that the x-,y- and subject data match by row by row. This means, each row number of x-data corresponds with the same row number of y-data and with the same row number of subject-data. This allows for compiling data components until these are ready for assembly into the so called "one data set". Therefore, this programme does not create the so called "one data set" already in the first step, but this creation process is splitted over the first 3 procedures. This improves maintenance as it allows to easily append data to the data set, just by adding data set components to the final data set.
    
The R script developed follows a general accepted programme structure (init, input, process/transform, output, close):

* a) Initialise
* b) Get source data
* c) Compile source data components. This part perfoms per component (measurements, activities and subjects) certain transformations wherer elevant: 
  * c.1) Consolidate source data
  * c.2) Subset source data
  * c.3) Apply descriptive labels
* d) Assemble source data components to source data set
* e) Create data product
* f) Output data product
* g) Close

The script extracts the variables which really represent a mean and not just all the variables with the string "mean" in the variable name. For example, 
the variable 561 angle(Z,gravityMean)
 does not represent a mean. Variables that represent a real mean typically contain the string "-mean" in the variable name.

The script uses the data.table package functionality to calculate the mean of the variables. The help of the data.table package shows the following usage of data.table: `"DT[,lapply(.SD,sum),by=x] (apply through columns by group)"`.  Data.table is known as being fast, but the main advantage on top of performance is the fact that you can add variables without the need to change this piece of code. The reason is that the .SD argument dynamically takes the columns which are not included in the "by" parameter. As a result, all variables except activity and subject are taken into account for mean calculation.

### INSTRUCTIONS TO RUN THE SCRIPT: 

Adapt set working directory statement in initialise procedure. This piece may be improved to dynamically set de working directory.