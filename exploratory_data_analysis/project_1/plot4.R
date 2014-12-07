#plot4
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
png("plot4.png",width = 480, height = 480)
par(mfrow=c(2,2),mar=c(5,4.5,1,1))
#1
with(data2, plot(as.POSIXct(Timing),Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type = "l",xlim=as.POSIXct(c("2007-02-01 00:00:00","2007-02-03 00:00:00"))))
#2
with(data2, plot(as.POSIXct(Timing),Voltage, xlab="datetime", ylab="Voltage", type = "l", xlim=as.POSIXct(c("2007-02-01 00:00:00","2007-02-03 00:00:00"))))
#3
with(data2,plot(as.POSIXct(Timing),Sub_metering_1,xlab="",ylab="Energy sub metering",type = "l",,xlim=as.POSIXct(c("2007-02-01 00:00:00","2007-02-03 00:00:00"))))
with(data2,lines(as.POSIXct(Timing),Sub_metering_2,col="red"))
with(data2,lines(as.POSIXct(Timing),Sub_metering_3,col="blue"))
legend("topright",lty=c(1,1,1), cex = 1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#4
with(data2, plot(as.POSIXct(Timing),Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type = "l", xlim=as.POSIXct(c("2007-02-01 00:00:00","2007-02-03 00:00:00"))))
dev.off()