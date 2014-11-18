setwd("~/R-PROJECT/xml_ming_code")
getwd()
library(XML)
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