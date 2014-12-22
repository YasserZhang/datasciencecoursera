library(dplyr)
files <- c("Beijing_2008_HourlyPM2.5_created20140325", 
           "Beijing_2009_HourlyPM25_created20140709", 
           "Beijing_2010_HourlyPM25_created20140709", 
           "Beijing_2011_HourlyPM25_created20140709", 
           "Beijing_2012_HourlyPM2.5_created20140325", 
           "Beijing_2013_HourlyPM2.5_created20140325", 
           "Beijing_2014_HourlyPM25_created20141201")

#画出2008到2014年每年pm 2.5日平均值的三点图
ap <- function(name=""){
  data_name <- paste(name,".csv",sep="")
  data <- read.csv(data_name,skip=3,header=T)
  data <- data[data$Value != -999,]
  names(data) <- sub("Date..LST.","Date",names(data))
  data$Date <- as.character(data$Date)
  for (i in 1:length(data$Date)){
    data$Date[i] <- unlist(strsplit(data$Date[i]," "))[1]
  }
  data <- as.tbl(data)
  data_Date <- group_by(data,Date)
  sub <- summarise(data_Date,mean=mean(Value))
  sub$Date <- as.POSIXct(sub$Date)
  #print(head(sub))
  year=as.character(data$Year[1])
  #print(year)
  pic_name <- paste("air_pollution_",year,".png",sep="")
  #print(pic_name)
  start = as.POSIXct(paste(year,"-01-01",sep=""))
  #print(start)
  end = as.POSIXct(paste(year,"-12-31",sep=""))
  lim=c(start,end)
  #print(lim)
  png(pic_name,height=480,width=960)
  with(sub,plot(Date,mean, main=year, ylab="Daily Mean Value",pch=19,xlim=lim,ylim=c(0,600)))
  abline(h=50,lty=1,col = "red")
  dev.off() 
}

for(name in files){
  ap(name)
}

#求一年中的最高值
maximum <- function(name=""){
  data_name <- paste(name,".csv",sep="")
  data <- read.csv(data_name,skip=3,header=T)
  data <- data[data$Value != -999,]
  names(data) <- sub("Date..LST.","Date",names(data))
  data$Date <- as.character(data$Date)
  for (i in 1:length(data$Date)){
    data$Date[i] <- unlist(strsplit(data$Date[i]," "))[1]
  }
  data <- as.tbl(data)
  data_Date <- group_by(data,Date)
  sub <- summarise(data_Date,mean=mean(Value))
  max <- sub[which(sub$mean==max(sub$mean)),]
  print(max)
}

maximum("Beijing_2014_HourlyPM25_created20141201")

for(name in files){
  maximum(name)
}

























data08 <- read.csv("Beijing_2008_HourlyPM2.5_created20140325.csv",skip = 3, header =T)
data08 <- data08[,1:8]

data08 <- data08[data08$Value != -999, ]
str(data08)
x <- sub("Date..LST.", "Date",names(data08))
names(data08) <- x
names(data08)
data08$Date <- as.character(data08$Date)

for (i in 1:length(data08$Date)){
  data08$Date[i] <- unlist(strsplit(data08$Date[i]," "))[1]
}
data08 <- as.tbl(data08)
str(data08)
data08_Date <- group_by(data08,Date)
sub08 <- summarise(data08_Date,mean=mean(Value))
sub08$Date <- as.POSIXct(sub08$Date)
png("air_pollution_2008.png",height=480,width=960)
with(sub08,plot(Date,mean, pch=19,xlim=as.POSIXct(c("2008-01-01","2008-12-31"))))
abline(h=50,lty=1,col = "red")
dev.off()





data09 <- read.csv("Beijing_2009_HourlyPM25_created20140709.csv",skip = 3, header = T)
data09 <- data09[,1:8]
data09 <- data09[data09$Value != -999,]
str(data09)
names(data09).split(".")
x <- sapply(names(data09),strsplit,split="\\.")
x <- sub("Date..LST.", "Date",names(data09))
names(data09) <- x
names(data09)
head(data09)
data09$Date <- as.character(data09$Date)

for (i in 1:length(data09$Date)){
  data09$Date[i] <- unlist(strsplit(data09$Date[i]," "))[1]
}

data09 <- as.tbl(data09)
str(data09)

data09_Date <- group_by(data09,Date)
sub09 <- summarise(data09_Date,mean=mean(Value))
sub09$Date <- as.POSIXct(sub09$Date)
png("air_pollution_2009.png",height=480,width=960)
with(sub09,plot(Date,mean, pch=19,xlim=as.POSIXct(c("2009-01-01","2009-12-31"))))
abline(h=50,lty=1,col = "red")
dev.off()


data10 <- read.csv("Beijing_2010_HourlyPM25_created20140709.csv",skip = 3, header =T)
data10 <- data10[,1:8]

data10 <- data10[data10$Value != -999, ]
str(data10)
x <- sub("Date..LST.", "Date",names(data10))
names(data10) <- x
names(data10)
data10$Date <- as.character(data10$Date)

for (i in 1:length(data10$Date)){
  data10$Date[i] <- unlist(strsplit(data10$Date[i]," "))[1]
}
data10 <- as.tbl(data10)
str(data10)
data10_Date <- group_by(data10,Date)
sub10 <- summarise(data10_Date,mean=mean(Value))
sub10$Date <- as.POSIXct(sub10$Date)
png("air_pollution_2010.png",height=480,width=960)
with(sub10,plot(Date,mean, pch=19,xlim=as.POSIXct(c("2010-01-01","2010-12-31"))))
abline(h=50,lty=1,col = "red")
dev.off()
