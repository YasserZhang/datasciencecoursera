s001 <- read.csv('specdata/001.csv')
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
"""
Write a function that reads a directory full of files and reports the number
of completely observed cases in each data file. The function should return
a data frame where the first column is the name of the file and the second column
is the number of complete cases.
"""
complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  data = data.frame()
  if (length(id)>1){
    for (i in id){
      if (i <10){
        filename  <- paste(directory, "/00", i, ".csv", sep = "")
        data = rbind(data, c(i, nrow(na.omit(read.csv(filename)))))
      }
      else if (i>=10 & i < 100){
        filename  <- paste(directory, "/0", i, ".csv", sep = "")
        data = rbind(data, c(i, nrow(na.omit(read.csv(filename)))))
      }
      else if (i >= 100){
        filename  <- paste(directory, "/", i, ".csv", sep = "")
        data = rbind(data, c(i, nrow(na.omit(read.csv(filename)))))
      }
    }
  }
  else {
    if (id < 10){filename  <- paste(directory, "/00", id, ".csv", sep = "")}
    else if (id >=10 & id < 100){filename  <- paste(directory, "/0", id, ".csv", sep = "")}
    else {filename  <- paste(directory, "/", id, ".csv", sep = "")}
    data = rbind(data, c(id, nrow(na.omit(read.csv(filename)))))
  }
  names(data) <- c('id','nobs')
  return (data)
  
}
# testing
complete("specdata", 1)
complete("specdata", c(2, 4, 8, 10, 12))
complete("specdata", 30:25)
complete("specdata", 3)
# another version of the solution to find complete cases, which is more concise. It seems the it is not neccessary
# to deal seperately with a single number picked for the id argument. 
# 没有必要单独理会id是个单一的值的情况。
complete <- function(directory, id = 1:332) {
  data = data.frame()
  for (i in id){
    if (i <10){
      filename  <- paste(directory, "/00", i, ".csv", sep = "")
      data = rbind(data, c(i, nrow(na.omit(read.csv(filename)))))
    }
    else if (i>=10 & i < 100){
      filename  <- paste(directory, "/0", i, ".csv", sep = "")
      data = rbind(data, c(i, nrow(na.omit(read.csv(filename)))))
    }
    else if (i >= 100){
      filename  <- paste(directory, "/", i, ".csv", sep = "")
      data = rbind(data, c(i, nrow(na.omit(read.csv(filename)))))
    }
  }
  names(data) <- c('id','nobs')
  return (data)
}

"""
Write a function that takes a directory of data files and a threshold for complete cases
and calculates the correlation between sulfate and nitrate for monitor locations where
the number of completely observed cases (on all variables) is greater than the threshold.
The function should return a vector of correlations for the monitors that meet the threshold
requirement. If no monitors meet the threshold requirement, then the function should return
a numeric vector of length 0.
"""
corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  id = 1:332
  cor_result = c()
  for (i in id){
    if (i <10){
      filename  <- paste(directory, "/00", i, ".csv", sep = "")
      data =na.omit(read.csv(filename))
      if (nrow(data) > threshold){
        cor_result = c(cor_result, cor(data[,"sulfate"],data[,"nitrate"]))
      }
    }
    else if (i>=10 & i < 100){
      filename  <- paste(directory, "/0", i, ".csv", sep = "")
      data =na.omit(read.csv(filename))
      if (nrow(data) > threshold){
        cor_result = c(cor_result, cor(data[,"sulfate"],data[,"nitrate"]))
      }
    }
    else if (i >= 100){
      filename  <- paste(directory, "/", i, ".csv", sep = "")
      data =na.omit(read.csv(filename))
      if (nrow(data) > threshold){
        cor_result = c(cor_result, cor(data[,"sulfate"],data[,"nitrate"]))
      }
    }
  }
  return (cor_result)
}

# testing
cr <- corr("specdata", 150)
head(cr)
summary(cr)
cr <- corr("specdata", 400)
head(cr)
cr <- corr("specdata", 5000)
summary(cr)
length(cr)
cr <- corr("specdata")
summary(cr)

