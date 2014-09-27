best <- function(state, outcome) {
  ## Read outcome data
  illness <- c('heart attack', 'heart failure', 'pneumonia')
  n <- c('Provider.Number','Hospital.Name', 'State', 'heart attack', 'heart failure', 'pneumonia')
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  ## Check that state and outcome are valid
  state = toupper(state)
  outcome=tolower(outcome)
  #create a subset that only include columns needed
  subset = data[,c(1,2,7,11,17,23)]
  #rename the column names
  names(subset) <- n
  if (!(state %in% unique(subset$State))){
    stop("invalid state")
  }
  else if(!(outcome %in% illness)){
    stop("invalid outcome")
  }
  else{
  subset = subset[subset$State == state,]
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  s <- apply(subset[,c(4,5,6)],2,as.numeric)
  res = subset[,2][which(s[,outcome]==min(s[,outcome],na.rm=TRUE))]
  return (sort(res)[1])
}}
