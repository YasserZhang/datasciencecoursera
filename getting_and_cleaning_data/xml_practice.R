setwd("~/R-PROJECT/xml_ming_code")
getwd()
library(XML)
library(plyr)
library(ggplot2)
library(gridExtra)


url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url,useInternalNodes=T)
xpathSApply(html,"//title",xmlValue)
cited <- xpathSApply(html,"//td[@class='gsc_a_c']",xmlValue)
title <- xpathSApply(html,"//td[@class='gsc_a_t']",xmlValue)
data <- data.frame(title=title, cited_by=cited)

library(httr)
html2 = GET(url)
content2 = content(ht)


# loading the xml file
xmlfile = xmlParse("pubmed_sample.xml")
class(xmlfile)
xmltop = xmlRoot(xmlfile)
class(xmltop)
xmlName(xmltop)
xmlSize(xmltop)
xmlName(xmltop[[1]])
xmlSize(xmltop[[1]])
xmltop[[1]]
xmltop[[2]]

n = xmlSize(xmltop)
for (i in 1:n) {
  print (paste(i, ": ", xmlSize(xmltop[[i]]), sep=""))
}

xmlSApply(xmltop[[1]],xmlName)
mode(xmlSApply(xmltop[[1]],xmlName))
xmlApply(xmltop[[1]],xmlName)
class(xmlApply(xmltop[[1]],xmlName))

xmlSApply(xmltop[[1]],xmlAttrs)
xmlSApply(xmltop[[1]],xmlSize)
# show the first node of the first node of the root node
xmltop[[1]][[1]]
# show its name
xmlName(xmltop[[1]][[1]])
# show the second node of the first node of the root node
xmltop[[1]][[2]]
# iterate through xmltop[[1]][[1]][[3]], show name of each sub node under it.
xmlSApply(xmltop[[1]][[1]][[3]],xmlName)


# loop through nodes under xmltop[[1]][[1]], show number of subnodes under each of xmltop[[1]][[1]]'s subnodes
n = xmlSize(xmltop[[1]][[1]])
for (i in 1:n) {
  print (paste(i, ": ", xmlSize(xmltop[[1]][[1]][[i]]), sep=""))
}
# also show names of these subnodes
for (i in 1:n) {
  print (paste(xmlName(xmltop[[1]][[1]][[i]]),": ", xmlSApply(xmltop[[1]][[1]][[i]],xmlName),sep=""))
}
# print text under node "Abstract" in the whole root node
xpathSApply(xmltop,"//Abstract",xmlValue)

# Turning XML into a dataframe
Madhu2012 = ldply(xmlToList("pubmed_sample.xml"),data.frame)
view(Madhu2012)
str(Madhu2012)
head(Madhu2012,1)
names(Madhu2012)
summary(Madhu2012)
Madhu2012.Clean = Madhu2012[Madhu2012[25]=='Y',]





------------------------------------
  """
How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page: 

http://biostat.jhsph.edu/~jleek/contact.html 

(Hint: the nchar() function in R may be helpful)
"""
url  <-  "http://biostat.jhsph.edu/~jleek/contact.html"
html <- htmlTreeParse(url,useInternalNodes=T)
download.file(url,destfile = "contact.txt",method = "curl")
htmlfile=readLines("contact.txt")
length(htmlfile)
nchar(htmlfile[10])
nchar(htmlfile[20])
nchar(htmlfile[30])
nchar(htmlfile[100])

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(url,destfile= "get")
fil = read.fwf("getdata-wksst8110.for", skip =4, widths=c(12, 7,4, 9,4, 9,4, 9,4))
dim(fil)
sum(fil[,4])
=======
  
  