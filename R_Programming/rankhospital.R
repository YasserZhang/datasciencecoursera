rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  num = as.character(num)
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  illness <- c('heart attack', 'heart failure', 'pneumonia')
  n <- c('Hospital.Name', 'State', 'heart attack', 'heart failure', 'pneumonia')
  #create a subset that only include columns needed
  subset = data[,c(2,7,11,17,23)]
  #rename the column names
  names(subset) <- n
  # coerce state and outcome to uppercase and lowercase respectively
  state = toupper(state)
  outcome= tolower(outcome)
  ## Check that state and outcome are valid  
  if (!(state %in% unique(subset$State))){
    stop("invalid state")
  }
  else if(!(outcome %in% illness)){
    stop("invalid outcome")
  }
  else{
    # subset a new data frame by state and overwrite the older one
    subset = subset[subset$State == state,]
    # create a sequence by the descending order of each hospital's outcome and its name,
    # putting NA values at the end of the sequence.
    subset[,outcome] = as.numeric(subset[,outcome])
    sequence = order(subset[,outcome], subset[, 1], na.last = TRUE)
    #rearrange rows of the data frame by the sequence
    subset = subset[sequence, ]
    # create a new column to store ranking information
    subset$Rank = seq_along(1:length(sequence))

  }
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  if (tolower(num) == "best" ) {
    return (subset[,1][subset$Rank == 1])
  } 
  else if (tolower(num) == "worst"){
    return (subset[,1][subset$Rank == sum(!is.na(subset[,outcome]))])
  } 
  else if (as.numeric(num) %in% 1:dim(subset)[1]){
    return (subset[,1][subset$Rank == as.numeric(num)])
  } 
  else {
    return (NA)
  }
}
