#plot2
library(sqldf)
#PREPARATION!
# put the downloaded file in the working directory and read needed data subset from dataset using sqldf
data2  <- read.csv.sql("./household_power_consumption.txt",header = T, sep = ";", stringsAsFactors = F, sql ="select * from file where Date = '1/2/2007' or Date = '2/2/2007'")
# convert the class fo Date values into "Date"
data2$Date = as.Date(data2$Date,"%d/%m/%Y")
# create a new column which combines $Date and $Time
# strftime return character vectors representing the time
data2$Timing = strftime(paste(data2$Date,data2$Time),"%Y-%m-%d %H:%M:%S")
#DRAWING
# create a png file storing the drawing in the current directory
png("plot2.png",width=480,height=480)
with(data2, plot(as.POSIXct(Timing),Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type = "l",xlim=as.POSIXct(c("2007-02-01 00:00:00","2007-02-03 00:00:00"))))
dev.off()