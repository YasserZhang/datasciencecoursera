rankall <- function(outcome, num = "best") {
  ## Read outcome data
  num = as.character(num)
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  illness <- c('heart attack', 'heart failure', 'pneumonia')
  n <- c('Hospital.Name', 'State', 'heart attack', 'heart failure', 'pneumonia')
  #create a subset that only include columns needed
  subset = data[,c(2,7,11,17,23)]
  #rename the column names
  names(subset) <- n
  # coerce outcome to uppercase and lowercase respectively
  outcome= tolower(outcome)
  ## Check that state and outcome are valid
  if(!(outcome %in% illness)){
    stop("invalid outcome")
  } else {
    subset[,outcome]=as.numeric(subset[,outcome])
    data_list <- split(subset,subset$State)
    ordered_data_list <- lapply(data_list, function(x){x=x[order(x[,outcome],x[,1]),]})
    #print(sapply(ordered_data_list,function(x){sum(x$State=="NA")}))
  }
  # build a function to calculate specific hospital name and state in terms of outcome and num
  rank <- function(l, num){
    # output hospital names in each state
    h_name = sapply(l, function(x){x[num,1]}) 
    # output each state's name
    s_name = sapply(l, function(x){x[1,2]})
    # return a data frame storing output hospital and state
    result = data.frame(hospital = h_name, state=s_name)
    #return (result)
  }
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name  
  if (tolower(num) == "best" ) {
  rank(ordered_data_list, 1)
  } 
  else if (tolower(num) == "worst"){
  h_name=sapply(ordered_data_list, function(x){x[sum(!is.na(x[,outcome])),1]})
  s_name = sapply(ordered_data_list, function(x){x[1,2]})
  result = data.frame(hospital = h_name, state=s_name)
  } 
  else if (as.numeric(num) %in% 1:dim(subset)[1]){
  rank(ordered_data_list, as.numeric(num))
  } 
  else {
    return (NA)
  }
}