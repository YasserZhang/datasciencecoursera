"""
Introduction

Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health. In the United States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine PM and for tracking the emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions of PM2.5. This database is known as the National Emissions Inventory (NEI). You can read more information about the NEI at the EPA National Emissions Inventory web site.

For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course of the entire year. The data that you will use for this assignment are for 1999, 2002, 2005, and 2008.
"""

"""
Data

The data for this assignment are available from the course web site as a single zip file:

Data for Peer Assessment [29Mb]
The zip file contains two files:

PM2.5 Emissions Data (summarySCC_PM25.rds): This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year. Here are the first few rows.

##     fips      SCC Pollutant Emissions  type year
## 4  09001 10100401  PM25-PRI    15.714 POINT 1999
## 8  09001 10100404  PM25-PRI   234.178 POINT 1999
## 12 09001 10100501  PM25-PRI     0.128 POINT 1999
## 16 09001 10200401  PM25-PRI     2.036 POINT 1999
## 20 09001 10200504  PM25-PRI     0.388 POINT 1999
## 24 09001 10200602  PM25-PRI     1.490 POINT 1999
fips: A five-digit number (represented as a string) indicating the U.S. county

SCC: The name of the source as indicated by a digit string (see source code classification table)

Pollutant: A string indicating the pollutant

Emissions: Amount of PM2.5 emitted, in tons

type: The type of source (point, non-point, on-road, or non-road)

year: The year of emissions recorded

Source Classification Code Table (Source_Classification_Code.rds): This table provides a mapping from the SCC digit strings in the Emissions table to the actual name of the PM2.5 source. The sources are categorized in a few different ways from more general to more specific and you may choose to explore whatever categories you think are most useful. For example, source “10100101” is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.

You can read each of the two files using the readRDS() function in R. For example, reading in each file can be done with the following code:

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
as long as each of those files is in your current working directory (check by calling dir() and see if those files are in the listing).

Assignment

The overall goal of this assignment is to explore the National Emissions Inventory database and see what it says about fine particulate matter pollution in the United states over the 10-year period 1999–2008. You may use any R package you want to support your analysis.
"""


#question 1
"""
Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
"""

library(dplyr)
scc <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
nei <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
nei <- as.tbl(nei)
nei_year <- group_by(nei,year)
summ <- summarise(nei_year,sum=sum(Emissions))
png("plot1.png",height = 480,width =480)
with(summ,plot(year,sum/1000,type="l",main ="PM 2.5 Emissions", ylab="thousand tons"))
dev.off()


#question 2
"""
Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.
"""
library(dplyr)
# load dataset
scc <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
nei <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
#transform the data type to tbl_df that is readable to dplyr
nei <- as.tbl(nei)
# make a subset of the dataset that only include the data of Baltimore
nei_baltimore  <- filter(nei,fips == "24510")
# group the subset data by year
nei_baltimore_year <- group_by(nei_baltimore,year)
# calculate the sum of yearly Emissions based on the grouping condition
summ <- summarise(nei_baltimore_year,sum=sum(Emissions))
# output the plot
png("plot2.png",height = 480,width =480)
with(summ,plot(year,sum,type="l", main = "PM 2.5 Emissions in Baltimore",ylab="tons"))
dev.off()

#question 3
library(dplyr)
scc <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
nei <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
nei <- as.tbl(nei)
# make a subset of the dataset that only include the data of Baltimore
nei_baltimore <- filter(nei,fips == "24510")
# group the subset data by year and type
nei_baltimore_year_type <- group_by(nei_baltimore, year,type)
# calculate the sum of yearly Emissions based on the grouping conditions
summ <- summarise(nei_baltimore_year_type,sum=sum(Emissions))
# output the plot
png('plot3.png',height = 480, width = 480)
qplot(year,sum,data= summ, geom = "line",color = type) + labs(y="tons") + labs(title = "PM 2.5 Emissions in Baltimore")
dev.off()



type <- c("POINT","NONPOINT","ON-ROAD","NON-ROAD")
par(mfrow=c(2,2))
for (t in type){
  type_sum <- nei_baltimore_year_type %>%
    filter(type == t) %>%
    summarise(sum=sum(Emissions))
  with(type_sum,plot(year,sum,type="l",main=paste(t," type of PM 2.5 Particle Emission"),ylab="tons"))
}

summ <- summarise(nei_baltimore_year_type,sum=sum(Emissions))
qplot(year,sum,data= summ, geom = "line",color = type)
summ$type  <- as.factor(summ$type)
qplot(year,sum,data= summ, geom = "line",color = type)



#question 4
scc <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
nei <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
nei <- as.tbl(nei)
scc <- as.tbl(scc)
# pick out factors indicating combustion related coal scources from EI.Sector category of SCC
coal <- c("Fuel Comb - Industrial Boilers, ICEs - Coal","Fuel Comb - Comm/Institutional - Coal", "Fuel Comb - Electric Generation - Coal")
# filter the dataset by these factors and get a subset data of SCC
scc2 <- filter(scc,EI.Sector %in% coal)
# filter the dataset of NEI by SCC code numbers included in the scc2 and get
# a subset data which only include Emissions from the source of combustion related coal
nei_coal <- filter(nei,SCC %in% scc2$SCC)
# group the subset data by year
nei_coal_year <- group_by(nei_coal,year)
# calculate the sum of yearly emssions based on the grouping condition
summ <- summarise(nei_coal_year,sum=sum(Emissions))
# output plot
png("plot4.png",height = 480,width=480)
with(summ,plot(year,sum/1000,type="l", main = "PM 2.5 Emissions from Combustion-Related Coal Consumption",ylab="thousand tons"))
dev.off()

#question 5
scc <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
nei <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
nei <- as.tbl(nei)
scc <- as.tbl(scc)
# pick out factors indicating emissions from motor vehicle sources from the EI.Sector category of SCC
motor <- c("Mobile - On-Road Gasoline Light Duty Vehicles",
           "Mobile - On-Road Gasoline Heavy Duty Vehicles",
           "Mobile - On-Road Diesel Light Duty Vehicles",
           "Mobile - On-Road Diesel Heavy Duty Vehicles")
# filter the dataset based on these factors and get a subset data of SCC
scc3 <- filter(scc,EI.Sector %in% motor)
# filter the dataset of nei to a subset that only include that data from Baltimore
nei_baltimore  <- filter(nei,fips == "24510")
# further filter the Baltimore data to get a new subdata that only include Emssions from motor vehicles sources
nei_baltimore_motor <- filter(nei_baltimore,SCC %in% scc3$SCC)
# calculate the sum of yearly emissions based on the conditioning of the year column
summ <- nei_baltimore_motor %>% group_by(year) %>% summarise(sum=sum(Emissions))
# output the plot
png("plot5.png",height = 480, width = 480)
with(summ,plot(year,sum,type="l", main = "PM 2.5 Emissions from Motor Vehicles in Baltimore",ylab="tons"))
dev.off()

#question 6
scc <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
nei <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
nei <- as.tbl(nei)
scc <- as.tbl(scc)
# pick out factors indicating emissions from motor vehicle sources from the EI.Sector category of SCC
motor <- c("Mobile - On-Road Gasoline Light Duty Vehicles",
           "Mobile - On-Road Gasoline Heavy Duty Vehicles",
           "Mobile - On-Road Diesel Light Duty Vehicles",
           "Mobile - On-Road Diesel Heavy Duty Vehicles")
# manipulate the data of Balitmore
nei_baltimore  <- filter(nei,fips == "24510")
nei_baltimore_motor <- filter(nei_baltimore,SCC %in% scc3$SCC)
summ_ba <- nei_baltimore_motor %>% group_by(year) %>% summarise(sum=sum(Emissions))
# manipulate the data of LA
nei_la <- filter(nei,fips == "06037")
nei_la_motor <- filter(nei_la,SCC %in% scc3$SCC)
summ_la <- nei_la_motor %>% group_by(year) %>% summarise(sum=sum(Emissions))
# output the plot
png("plot6.png",height=480,width=480)
par(mai=c(1.2,1,1,1.2))
with(summ_ba,plot(year,sum, type="l",col = "red", xlim = c(1998,2009),ylim=c(80,350),ylab="Motor Emissions in Baltimore (tons)"))
title(main = "Camparison on PM 2.5 Emissions from Motor Vehicles\n between Baltimore and LA")
par(new=TRUE)
with(summ_la,plot(year,sum/10,col="blue",ylim=c(80,460),xaxt="n",yaxt="n",ylab="",type="l"))
axis(4,at=seq(80,460,by=round(380/5)))
text(2009.8, 270, "Motor Emission in LA (10 tons)", srt = 270, xpd = TRUE)
legend("bottomleft",lty=c(1,1),col=c("blue","red"),legend=c("LA","Bal"))
dev.off()


------------------
scc <- readRDS("Source_Classification_Code.rds")
nei <- readRDS("summarySCC_PM25.rds")
str(nei)
unique(nei$Pollutant)
unique(nei$type)
head(nei)
with(nei,plot(year,Emissions,lty="l"))
with(nei,hist(Emissions))
summary(nei$Emissions)




library(dplyr)
nei <- as.tbl(nei)
class(nei)
nei_year <- group_by(nei,year)
str(nei_year)
class(nei_year)
head(nei_year)
summ <- summarise(nei_year,sum=sum(Emissions))
summ
unique(nei$year)
with(summ,plot(year,sum,type="l"))


nei_baltimore  <- filter(nei,fips == "24510")
head(nei_baltimore)
nei_baltimore_year <- group_by(nei_baltimore,year)
summ <- summarise(nei_baltimore_year,sum=sum(Emissions))
with(summ,plot(year,sum,type="l"))

nei_baltimore_year_type <- group_by(nei_baltimore,year,type)
head(nei_baltimore_year_type)
summ_point  <- nei_baltimore_year_type %>% filter(type == "POINT") %>% summarise(sum=sum(Emissions))
summ_point
with(summ_point,plot(year,sum,type="l"))

unique(nei_baltimore_year_type$type)
type <- c("POINT","NONPOINT","ON-ROAD","NON-ROAD")
par(mfrow=c(2,2))
for (t in type){
  type_sum <- nei_baltimore_year_type %>% filter(type == t) %>% summarise(sum=sum(Emissions))
  with(type_sum,plot(year,sum,type="l",main=paste(t," type of PM 2.5 Particle Emission"),ylab="tons"))
}



str(scc)
names(scc)
x <- gregexpr("coal",scc$EI.Sector)
str(x)
unique(x==T)


scc <- as.tbl(scc)
coal <- c("Fuel Comb - Industrial Boilers, ICEs - Coal","Fuel Comb - Comm/Institutional - Coal", "Fuel Comb - Electric Generation - Coal")
scc2 <- filter(scc,EI.Sector %in% coal)
scc2
dim(scc2)
nei_coal <- filter(nei,SCC %in% scc2$SCC)
head(nei_coal)
nei_coal_year <- group_by(nei_coal,year)
summ <- summarise(nei_coal_year,sum=sum(Emissions))
with(summ,plot(year,sum,type="l"))





motor <- c("Mobile - On-Road Gasoline Light Duty Vehicles",
          "Mobile - On-Road Gasoline Heavy Duty Vehicles",
          "Mobile - On-Road Diesel Light Duty Vehicles",
          "Mobile - On-Road Diesel Heavy Duty Vehicles")
scc3 <- filter(scc,EI.Sector %in% motor)
nei_baltimore  <- filter(nei,fips == "24510")
nei_baltimore_motor <- filter(nei_baltimore,SCC %in% scc3$SCC)
summ <- nei_baltimore_motor %>% group_by(year) %>% summarise(sum=sum(Emissions))
with(summ,plot(year,sum,type="l"))


nei_la <- filter(nei,fips == "06037")
nei_la_motor <- filter(nei_la,SCC %in% scc3$SCC)
summ_la <- nei_la_motor %>% group_by(year) %>% summarise(sum=sum(Emissions))
with(summ_la,plot(year,scale(sum),type="l"))
with(summ,plot(year,scale(sum),type="l"))

#baltimore
summ
#LA
summ_la


summ$chang_rate  <- rep(1,4)
summ_la$change_rate <- rep(1,4)
summ
for (i in 2:4) {
  summ$change_rate[i] = (summ$sum[i]-summ$sum[i-1])/summ$sum[]
}
change <- function(data){
  data$change_rate = rep(1,4)
  for (i in 2:4){
    data$change_rate[i]  <-  (data$sum[i] - data$sum[i-1])/data$sum[i-1]
    print(data$change_rate[i])
  }
  return(data)
}
Baltimore <- change(summ)
LA <- change(summ_la)
Baltimore$change_rate[1] = 0
LA$change_rate[1] = 0
par(mfrow=c(1,2))
with(Baltimore,plot(year,scale(sum),type="l"))
with(LA,plot(year,scale(sum),type="l"))


nei_la <- filter(nei,fips == "06037")
nei_baltimore  <- filter(nei,fips == "24510")

nei_ba_la <- filter(nei,fips %in% c("06037","24510"))
motor <- c("Mobile - On-Road Gasoline Light Duty Vehicles",
           "Mobile - On-Road Gasoline Heavy Duty Vehicles",
           "Mobile - On-Road Diesel Light Duty Vehicles",
           "Mobile - On-Road Diesel Heavy Duty Vehicles")
scc3 <- filter(scc,EI.Sector %in% motor)
nei_bala_motor <- filter(nei_ba_la,SCC %in% scc3$SCC)
nei_bala_motor_group <- group_by(nei_bala_motor,year,fips)
summ_bala <- summarise(nei_bala_motor_group,sum=sum(Emissions))
summ_ba <- filter(summ_bala,fips=="24510")
summ_ba$scale <- scale(summ_ba$sum)
summ_la <- filter(summ_bala,fips=="06037")
summ_la$scale <- scale(summ_la$sum)

summ_bala
qplot(year,scaling,data=summ_bala,geom="line",color=fips)

p <- ggplot() + 
  geom_line(data = summ_ba, aes(x = year, y = scale, color = "red")) +
  geom_line(data = summ_la, aes(x = year, y = scale, color = "blue"))  +
  xlab('year') +
  ylab('tons')
p

# Draw first plot        
plot(x,y1,xlim=c(0,10),ylim=c(0,10), ylab="y1", las = 1)
title(main="Multiple Y-Axes in R")
# Draw second plot
#par(new=TRUE)
plot(x,y2,xlim=c(0,10),xaxt="n",yaxt="n",ylab="",pch=16)
axis(4,at=c(0,20,40,60,80,100))
text(11, 50, "y2", srt = 270, xpd = TRUE)



par(mai=c(1.2,1,1,1.2))
with(summ_ba,plot(year,sum, type="l",col = "red", ylim=c(80,350),ylab="Motor Emissions in Baltimore (tons)"))
title(main = "Camparison on PM 2.5 Emissions from Motor Vehicles between Baltimore and LA")
par(new=TRUE)
with(summ_la,plot(year,sum,col="blue",ylim=c(3900,4600),xaxt="n",yaxt="n",ylab="",type="l"))
axis(4,at=seq(3900,4700,by=round(700/4)))
text(2009.8, 4300, "Motor Emission in LA (tons)", srt = 270, xpd = TRUE)

