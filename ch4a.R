
# Type reassignment

# Functions: 
# as.number()
# as.character()
# == 
# class()
# is.list()
# names(l) <- c(1,2,3,4,5) To name columns

x <- 1
as.logical(x)
x <- as.character(x)
as.logical(x)

y <- "true"
class(y)
as.logical(y)

# Type coercion
"1" == 1
"1" == 2
1 == TRUE
"1" == TRUE

as.logical(2)
2 == TRUE

"TRUE" == TRUE
"true" == TRUE

# Lists: useful when storing objects of unknown type

l <- list(x,y,"z",FALSE,2)
l2 <- list(l,x,l)
length(l2)

# Single bracket weirdness
l2[1]
l2[1][1]
l2[1][1][1]

l2[[1]]
l2[[1]][1]
is.list(l2[[1]][1])

# Double brackets FTW
l2[[1]][[1]]
is.list(l2[[1]][[1]])

# Name your observations!

names(l)
length(l)
names(l) <- c(1,2,3,4,5)
names(l) <- c("a","b","c","d") #Forces you to change all the names of the dataframe. 
                                # If the last or more are not considered it will change 
                                # the column name to NA
names(l)[5] <- "e"

# Factor variables for categorical observations

p <- c("Democrat","Democrat","Republican","Republican")
p2 <- factor(c("Democrat","Democrat","Republican","Republican"))

levels(p)
levels(p2)

table(p)
table(p)[1]
table(p)[1]*2

factor(p2, levels = c("democrat", "republican")) #case matters
factor(p2, levels = c("Democrat", "Republican","Independent"))

# Multi-dimensional data

bad = cbind(c1 = c(10,5),c2 = c("a","b")) #cbind turns things into matrix
bad

is.matrix(bad)
is.data.frame(bad)

good = data.frame(c1 = c(10,5),c2 = c("a","b"))
good

is.matrix(good)
is.data.frame(good)

bad[,1]
class(bad[,1])

good[,1]
class(good[,1])

bad$c1
good$c1

# Subsetting: $, [, and [[

order(good$c1)
good[order(good$c1),] # what we want
good[order(good$c1)] # not what we want

# Note: Dataframes are lists of columns
good

good[1]
good[1][1]

good[[1]]
good[[1]][1]

# The following are equivalent
good[[1]]
good$c1
good[["c1"]]

# You can also index backwards
good[[-1]]
good[[-2]]

# Out of bounds
good[[-3]]
good[[3]]

# Subassignment

good

good$c1[good$c1 < 10] <- 0
good

good$c2[good$c1 < 10] <- "c"
good

ls()

rm(x)
ls()

rm("y")
ls()

rm(list = ls())
ls()

