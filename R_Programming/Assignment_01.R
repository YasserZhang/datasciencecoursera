setwd("~/R_Project/specdata")
s001 <- read.csv('001.csv')
head(s001)
summary(s001)
dim(complete.cases(s001))
na.omit(s001)
##The Data
"""
The zip file contains 332 comma-separated-value (CSV) files containing pollution
monitoring data for fine particulate matter (PM) air pollution at 332 locations
in the United States. Each file contains data from a single monitor and the ID
number for each monitor is contained in the file name. For example, data for
monitor 200 is contained in the file "200.csv". Each file contains three
variables:

Date: the date of the observation in YYYY-MM-DD format (year-month-day)
sulfate: the level of sulfate PM in the air on that date
(measured in micrograms per cubic meter)
nitrate: the level of nitrate PM in the air on that date
(measured in micrograms per cubic meter)

"""
"""

Write a function named 'pollutantmean' that calculates the mean of
a pollutant (sulfate or nitrate) across a specified list of monitors.
The function 'pollutantmean' takes three arguments: 'directory', 'pollutant',
and 'id'. Given a vector monitor ID numbers, 'pollutantmean' reads that
monitors' particulate matter data from the directory specified in the
'directory' argument and returns the mean of the pollutant across all of
the monitors, ignoring any missing values coded as NA.

"""
# calculate the mean value of observations on one pollutant from one or more stations.
# The tricky thing is about how to deal with those zeros before the one-digit and two-digit
# numbers.
pollutantmean <- function(directory, pollutant, id = 1:332){
  data = data.frame()
  if (length(id)>1){
    for (i in id){
      if (i <10){
        filename  <- paste(directory, "/00", i, ".csv", sep = "")
        data = rbind(data, read.csv(filename))
                }
      else if (i>=10 & i < 100){
        filename  <- paste(directory, "/0", i, ".csv", sep = "")
        data = rbind(data, read.csv(filename))
                                }
      else if (i >= 100){
        filename  <- paste(directory, "/", i, ".csv", sep = "")
        data =rbind(data, read.csv(filename))
                        }
                }
                    }
  else {
    if (id < 10){filename  <- paste(directory, "/00", id, ".csv", sep = "")}
    else if (id >=10 & id < 100){filename  <- paste(directory, "/0", id, ".csv", sep = "")}
    else {filename  <- paste(directory, "/", id, ".csv", sep = "")}
    data = rbind(data, read.csv(filename))
  }
  m  <- mean(data[,pollutant],na.rm = T)
  return (round(m, digits = 3))
}

# testing the function's working state.
pollutantmean("specdata", "sulfate", 1:10)
pollutantmean("specdata", "nitrate", 70:72)
pollutantmean("specdata", "nitrate", 23)

-------------------------------------------------------------------------
