Sys.setenv(PKG_CPPFLAGS = "-I/usr/local/include/mysql")
Sys.setenv(PKG_LIBS = "-L/usr/local/lib -lmysqlclient")
install.packages("RMySQL", type = "source")
library(RMySQL)
# connecting the genome database at ucsc.edu, university of california at santa cruz
ucscDb <- dbConnect(MySQL(),user="genome",host="genome-mysql.cse.ucsc.edu")
# getting headers of the database
result <- dbGetQuery(ucscDb,"show databases;")
# closing the connection
dbDisconnect(ucscDb)
# getting a database named "hg19"
hg19 <- dbConnect(MySQL(),user="genome",db="hg19",host="genome-mysql.cse.ucsc.edu")
# forming into a database
allTables <- dbListTables(hg19)
length(allTables)
summary(allTables)
dim(allTables)
class(allTables)
head(allTables,100)
colnames(allTables)
class(allTables[1])

# listing all fields or columns in one of its tables
dbListFields(hg19,"affyU133Plus2")
which(allTables=="affyU133Plus2")
# Run an arbitrary SQL statement and extract all its output (returns a data.frame)
dbGetQuery(hg19,"select count(*) from affyU133Plus2")
affyData <- dbReadTable(hg19,"affyU133Plus2")
head(affyData)
class(affyData)
dim(affyData)
str(affyData)
# Run an SQL statement and extract its output in pieces (returns a result set)
query <- dbSendQuery(hg19,"select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query)

quantile(affyMis$misMatches)
class(affyMis)
dim(affyMis)
str(affyMis)
affyMis <- fetch(query,n=10)
# clear off the query
dbClearResult(affyMis)
dbClearResult(query)
# after clearing off the query, you can't fetch data from it any more.
affyMis <- fetch(query,n=10)
# always remember disconnect the database!!!
dbDisconnect(hg19)








