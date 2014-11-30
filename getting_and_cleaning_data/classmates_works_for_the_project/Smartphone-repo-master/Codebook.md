### Tidy data

Bij definition, (video 03_04_reshapingData, page 2), tidy data complies to:

* each variable forms a column
* each observation forms a row
* each table stores one type of observation (e.g. here body movements)

In below data table definition there are no variables as a row attribute; all observations are represented by rows (aggregated to activity and subject); no observations are represented columnwise; the data table definition tells that only data on body movements are stored. Therefore the data set will be tidy.


### Key/grouping attributes

* activity: (type = character, possible values = "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING".
* subject: (type = integer, possible values 1:30). Each subject represents an ID which refers to a specific person. There are no meta data available (name, et cetera). 


### Variables

The below variables are aggregates of measures, aggregated by above activity and subject. Within each group of activity and subject the mean value of the original measures has been calculated. Therefore the below variables are indicated with the prefix "mean-of-". 

The original vaiables are described by the code book belonging to the following data set provided by UCI:
	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The original data set can be optained here: 
	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

```
----Output variable-------------------------Definition----------------------------------------------------------Type----Length.dec
1	mean-of-tBodyAcc-mean()-X              	mean of 	tBodyAcc-mean()-X              	by activity, subject	numeric	"9.7"
2	mean-of-tBodyAcc-mean()-Y              	mean of 	tBodyAcc-mean()-Y              	by activity, subject	numeric	"9.7"
3	mean-of-tBodyAcc-mean()-Z              	mean of 	tBodyAcc-mean()-Z              	by activity, subject	numeric	"9.7"
4	mean-of-tGravityAcc-mean()-X           	mean of 	tGravityAcc-mean()-X           	by activity, subject	numeric	"9.7"
5	mean-of-tGravityAcc-mean()-Y           	mean of 	tGravityAcc-mean()-Y           	by activity, subject	numeric	"9.7"
6	mean-of-tGravityAcc-mean()-Z           	mean of 	tGravityAcc-mean()-Z           	by activity, subject	numeric	"9.7"
7	mean-of-tBodyAccJerk-mean()-X          	mean of 	tBodyAccJerk-mean()-X          	by activity, subject	numeric	"9.7"
8	mean-of-tBodyAccJerk-mean()-Y          	mean of 	tBodyAccJerk-mean()-Y          	by activity, subject	numeric	"9.7"
9	mean-of-tBodyAccJerk-mean()-Z          	mean of 	tBodyAccJerk-mean()-Z          	by activity, subject	numeric	"9.7"
10	mean-of-tBodyGyro-mean()-X             	mean of 	tBodyGyro-mean()-X             	by activity, subject	numeric	"9.7"
11	mean-of-tBodyGyro-mean()-Y             	mean of 	tBodyGyro-mean()-Y             	by activity, subject	numeric	"9.7"
12	mean-of-tBodyGyro-mean()-Z             	mean of 	tBodyGyro-mean()-Z             	by activity, subject	numeric	"9.7"
13	mean-of-tBodyGyroJerk-mean()-X         	mean of 	tBodyGyroJerk-mean()-X         	by activity, subject	numeric	"9.7"
14	mean-of-tBodyGyroJerk-mean()-Y         	mean of 	tBodyGyroJerk-mean()-Y         	by activity, subject	numeric	"9.7"
15	mean-of-tBodyGyroJerk-mean()-Z         	mean of 	tBodyGyroJerk-mean()-Z         	by activity, subject	numeric	"9.7"
16	mean-of-tBodyAccMag-mean()             	mean of 	tBodyAccMag-mean()             	by activity, subject	numeric	"9.7"
17	mean-of-tGravityAccMag-mean()          	mean of 	tGravityAccMag-mean()          	by activity, subject	numeric	"9.7"
18	mean-of-tBodyAccJerkMag-mean()         	mean of 	tBodyAccJerkMag-mean()         	by activity, subject	numeric	"9.7"
19	mean-of-tBodyGyroMag-mean()            	mean of 	tBodyGyroMag-mean()            	by activity, subject	numeric	"9.7"
20	mean-of-tBodyGyroJerkMag-mean()        	mean of 	tBodyGyroJerkMag-mean()        	by activity, subject	numeric	"9.7"
21	mean-of-fBodyAcc-mean()-X              	mean of 	fBodyAcc-mean()-X              	by activity, subject	numeric	"9.7"
22	mean-of-fBodyAcc-mean()-Y              	mean of 	fBodyAcc-mean()-Y              	by activity, subject	numeric	"9.7"
23	mean-of-fBodyAcc-mean()-Z              	mean of 	fBodyAcc-mean()-Z              	by activity, subject	numeric	"9.7"
24	mean-of-fBodyAcc-meanFreq()-X          	mean of 	fBodyAcc-meanFreq()-X          	by activity, subject	numeric	"9.7"
25	mean-of-fBodyAcc-meanFreq()-Y          	mean of 	fBodyAcc-meanFreq()-Y          	by activity, subject	numeric	"9.7"
26	mean-of-fBodyAcc-meanFreq()-Z          	mean of 	fBodyAcc-meanFreq()-Z          	by activity, subject	numeric	"9.7"
27	mean-of-fBodyAccJerk-mean()-X          	mean of 	fBodyAccJerk-mean()-X          	by activity, subject	numeric	"9.7"
28	mean-of-fBodyAccJerk-mean()-Y          	mean of 	fBodyAccJerk-mean()-Y          	by activity, subject	numeric	"9.7"
29	mean-of-fBodyAccJerk-mean()-Z          	mean of 	fBodyAccJerk-mean()-Z          	by activity, subject	numeric	"9.7"
30	mean-of-fBodyAccJerk-meanFreq()-X      	mean of 	fBodyAccJerk-meanFreq()-X      	by activity, subject	numeric	"9.7"
31	mean-of-fBodyAccJerk-meanFreq()-Y      	mean of 	fBodyAccJerk-meanFreq()-Y      	by activity, subject	numeric	"9.7"
32	mean-of-fBodyAccJerk-meanFreq()-Z      	mean of 	fBodyAccJerk-meanFreq()-Z      	by activity, subject	numeric	"9.7"
33	mean-of-fBodyGyro-mean()-X             	mean of 	fBodyGyro-mean()-X             	by activity, subject	numeric	"9.7"
34	mean-of-fBodyGyro-mean()-Y             	mean of 	fBodyGyro-mean()-Y             	by activity, subject	numeric	"9.7"
35	mean-of-fBodyGyro-mean()-Z             	mean of 	fBodyGyro-mean()-Z             	by activity, subject	numeric	"9.7"
36	mean-of-fBodyGyro-meanFreq()-X         	mean of 	fBodyGyro-meanFreq()-X         	by activity, subject	numeric	"9.7"
37	mean-of-fBodyGyro-meanFreq()-Y         	mean of 	fBodyGyro-meanFreq()-Y         	by activity, subject	numeric	"9.7"
38	mean-of-fBodyGyro-meanFreq()-Z         	mean of 	fBodyGyro-meanFreq()-Z         	by activity, subject	numeric	"9.7"
39	mean-of-fBodyAccMag-mean()             	mean of 	fBodyAccMag-mean()             	by activity, subject	numeric	"9.7"
40	mean-of-fBodyAccMag-meanFreq()         	mean of 	fBodyAccMag-meanFreq()         	by activity, subject	numeric	"9.7"
41	mean-of-fBodyBodyAccJerkMag-mean()     	mean of 	fBodyBodyAccJerkMag-mean()     	by activity, subject	numeric	"9.7"
42	mean-of-fBodyBodyAccJerkMag-meanFreq() 	mean of 	fBodyBodyAccJerkMag-meanFreq() 	by activity, subject	numeric	"9.7"
43	mean-of-fBodyBodyGyroMag-mean()        	mean of 	fBodyBodyGyroMag-mean()        	by activity, subject	numeric	"9.7"
44	mean-of-fBodyBodyGyroMag-meanFreq()    	mean of 	fBodyBodyGyroMag-meanFreq()    	by activity, subject	numeric	"9.7"
45	mean-of-fBodyBodyGyroJerkMag-mean()    	mean of 	fBodyBodyGyroJerkMag-mean()    	by activity, subject	numeric	"9.7"
46	mean-of-fBodyBodyGyroJerkMag-meanFreq()	mean of 	fBodyBodyGyroJerkMag-meanFreq()	by activity, subject	numeric	"9.7"
```







