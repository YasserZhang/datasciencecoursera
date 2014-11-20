source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library(rhdf5)

# create hierachical data structure in hdf5
created = h5createFile("example.h5")
created
created = h5createGroup("example.h5","foo")
created = h5createGroup("example.h5","baa")
created = h5createGroup("example.h5","foo/foobaa")
h5ls("example.h5")

# write data into hdf5
A = matrix(1:10,nr=5,nc=2)
h5write(A,"example.h5","foo/A")
B = array(seq(0.1,2.0,by=0.1), dim=c(5,2,2))
attr(B,"scale") <- "liter"
h5write(B,"example.h5","foo/foobaa/B")
h5ls("example.h5")

#write a data frame into the hdf5 dataset
df = data.frame(a=1L:5L,b=seq(0,1,length.out = 5),c=c("ab","cde","fghi","a","s"),stringsAsFactors=F)
h5write(df,"example.h5","df")
h5ls("example.h5")

# read data fram from hdf5 dataset
readA = h5read("example.h5","foo/A")
readB = h5read("example.h5","foo/foobaa/B")
readdf = h5read("example.h5","df")
readA
# update specific variables in hdf5
h5write(c(12,13,14),"example.h5","foo/A",index=list(1:3,1))
h5read("example.h5","foo/A")


