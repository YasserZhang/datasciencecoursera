library(dplyr)
library(sqldf)
# read the entire dataset into the memory
data <- read.table("household_power_consumption.txt", header =T, sep=";",stringsAsFactors = F)
# put the downloaded file in the working directory and read needed data subset from dataset using sqldf
data2  <- read.csv.sql("./household_power_consumption.txt",header = T, sep = ";", stringsAsFactors = F, sql ="select * from file where Date = '1/2/2007' or Date = '2/2/2007'")

# calculate how much memory the dataset will need
predict_data_size = function(numeric_size, number_type = "numeric") {
  if(number_type == "integer") {
    byte_per_number = 4
  } else if(number_type == "numeric") {
    byte_per_number = 8
  } else {
    stop(sprintf("Unknown number_type: %s", number_type))
  }
  estimate_size_in_bytes = (numeric_size * byte_per_number)
  class(estimate_size_in_bytes) = "object_size"
  print(estimate_size_in_bytes, units = "auto")
}
predict_data_size(2075259*9,"numeric")
142.5 Mb

data = tbl_df(data)
data1  <- data %>% filter(Date %in% c("1/2/2007","2/2/2007"))

names(data)
[1] "Date"                  "Time"                  "Global_active_power"   "Global_reactive_power" "Voltage"              
[6] "Global_intensity"      "Sub_metering_1"        "Sub_metering_2"        "Sub_metering_3"  
dim(data)
class(data$Date)

rm(data)
length(which(data$Date == "1/2/2007"))
str(data)
head(data)

data$Date = as.Date(data$Date)
which(data$Date == "02-01-2007")
head(data)
#experiment on date
data3 = data2
data3$Date = as.Date(data3$Date, "%d/%m/%Y")
head(data3$Date,5)

day = paste(head(data3$Date,5),head(data3$Time,5))
strftime(day,"%Y-%m-%d %H:%M:%S")
#success!!!
########
strftime(day,"%e-%m-%Y %H:%M:%S")
str(data2)
weekdays(as.Date("1/2/2007","%e/%e/%Y"))


data2$Date = as.Date(data2$Date,"%d/%m/%Y")
data2$Timing = strftime(paste(data2$Date,data2$Time),"%Y-%m-%d %H:%M:%S")
class(data2$Timing)
data2$Timing = ts(data2$Timing)
head(data2$Timing)
tm
tms = ts(weekdays(data2$Date))
head(tms)
#plot1
#PREPARATION!
# put the downloaded file in the working directory and read needed data subset from dataset using sqldf
data2  <- read.csv.sql("./household_power_consumption.txt",header = T, sep = ";", stringsAsFactors = F, sql ="select * from file where Date = '1/2/2007' or Date = '2/2/2007'")
# convert the class fo Date values into "Date"
data2$Date = as.Date(data2$Date,"%d/%m/%Y")
# create a new column which combines $Date and $Time
# strftime return character vectors representing the time
data2$Timing = strftime(paste(data2$Date,data2$Time),"%Y-%m-%d %H:%M:%S")
#DRAWING
png("plot1.png",width=480,height=480)
with(data2, hist(Global_active_power,col ="red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power"))
dev.off()

#plot2
# 以下是为绘制plot2所做的尝试，很多失败，主要问题在于作为X轴的时间数据必须转为POSIXct格式
# 另外还要添加xlim，其最大和最小值也必须是POSIXct格式
with(data2,plot(Global_active_power ~ as.factor(Date), xaxt="n",type="l",na.rm=T))
data2s <- data2[,c("Date","Global_active_power")]
plot.ts(data2s)
plot(weekdays(data2$Date),data2$Global_active_power, xlim=as.array(unique(weekdays(data2$Date))))
plot(tms,data2$Global_active_power,na.rm =T,xaxt = "n",xlim=c(1,3))
head(data2$Global_active_power)
summary(data2$Global_active_power)
length(tms)
head(data2)
a = min(data2$Timing)
b = max(data2$Timing)
plot(data2$Timing,data2$Global_active_power,type="l",xlim=c(min(data2$Timing),max(data2$Timing)))
min(data2$Timing)
max(data2$Timing)
data4 = data2[1:100,]
data2$Timing = as.character(data2$Timing)
class(data4$Timing)
class(data4$Global_active_power)
with(data2,plot(Timing,Global_active_power, xaxt = "n",type="l",xlim=as.POSIXct(c("2007-02-01 00:00:00","2007-02-03 00:00:00"))))
plot(as.POSIXct(data2$Timing),data2$Global_active_power,type="l",xlim=as.POSIXct(c("2007-02-01 00:00:00","2007-02-03 00:00:00")))
class(data2$Timing)

#plot2
#PREPARATION!
# put the downloaded file in the working directory and read needed data subset from dataset using sqldf
data2  <- read.csv.sql("./household_power_consumption.txt",header = T, sep = ";", stringsAsFactors = F, sql ="select * from file where Date = '1/2/2007' or Date = '2/2/2007'")
# convert the class fo Date values into "Date"
data2$Date = as.Date(data2$Date,"%d/%m/%Y")
# create a new column which combines $Date and $Time
# strftime return character vectors representing the time
data2$Timing = strftime(paste(data2$Date,data2$Time),"%Y-%m-%d %H:%M:%S")
#DRAWING
png("plot2.png",width=480,height=480)
with(data2, plot(as.POSIXct(Timing),Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type = "l",xlim=as.POSIXct(c("2007-02-01 00:00:00","2007-02-03 00:00:00"))))
dev.off()


#plot3
#PREPARATION!
# put the downloaded file in the working directory and read needed data subset from dataset using sqldf
data2  <- read.csv.sql("./household_power_consumption.txt",header = T, sep = ";", stringsAsFactors = F, sql ="select * from file where Date = '1/2/2007' or Date = '2/2/2007'")
# convert the class fo Date values into "Date"
data2$Date = as.Date(data2$Date,"%d/%m/%Y")
# create a new column which combines $Date and $Time
# strftime return character vectors representing the time
data2$Timing = strftime(paste(data2$Date,data2$Time),"%Y-%m-%d %H:%M:%S")
#DRAWING
png("plot3.png",width=480,height = 480)
with(data2,plot(as.POSIXct(Timing),Sub_metering_1,xlab="",ylab="Energy sub metering",type = "l",,xlim=as.POSIXct(c("2007-02-01 00:00:00","2007-02-03 00:00:00"))))
with(data2,lines(as.POSIXct(Timing),Sub_metering_2,col="red"))
with(data2,lines(as.POSIXct(Timing),Sub_metering_3,col="blue"))
legend("topright",lty=c(1,1,1), cex = 0.8, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

#plot4
#PREPARATION!
# put the downloaded file in the working directory and read needed data subset from dataset using sqldf
data2  <- read.csv.sql("./household_power_consumption.txt",header = T, sep = ";", stringsAsFactors = F, sql ="select * from file where Date = '1/2/2007' or Date = '2/2/2007'")
# convert the class fo Date values into "Date"
data2$Date = as.Date(data2$Date,"%d/%m/%Y")
# create a new column which combines $Date and $Time
# strftime return character vectors representing the time
data2$Timing = strftime(paste(data2$Date,data2$Time),"%Y-%m-%d %H:%M:%S")
#DRAWING
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







