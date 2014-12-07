#plot1
library(sqldf)
#PREPARATION!
# put the downloaded file in the working directory and read needed data subset from dataset using sqldf
data2  <- read.csv.sql("./household_power_consumption.txt",header = T, sep = ";", stringsAsFactors = F, sql ="select * from file where Date = '1/2/2007' or Date = '2/2/2007'")

#DRAWING
# create a png file storing the drawing in the current directory
png("plot1.png",width=480,height=480)
with(data2, hist(Global_active_power,col ="red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power"))
dev.off()