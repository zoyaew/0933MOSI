# Rename this file to "Inclass_04_YourName.R", where YourName is changed to your own name.
# Name: zewahyu (Revision)
# ID:
################# Task 1: Writing a Data Summarization Function ############### 
# (a) Rewrite the code (from Task 5 of the 3rd in-class exercise) as a function 
# with the name `groupwise.sum.fun` and the parameter list `(data, columns, grouping)`. 
# It should allow users to change the data frame, the columns and the grouping rule. 
setwd("C:/Users/LENOVO/Downloads/ISOM3390/topic4")
pros.dat <- read.table("pros.dat")

groupwise.sum.fun <- function(data, columns, grouping){
  rowsum(data[,columns], grouping)
}
set.seed(0)
grouping <- sample(2:5, size = 97, replace = T)
groupwise.sum.fun(data = pros.dat, columns = c(2, 8, 3, 6), grouping = grouping)

# (b) Define default values for the `columns` and `grouping` parameters for the `groupwise.sum.fun` function.
groupwise.sum.fun <- function(data, columns=1:ncol(pros.dat), grouping=array(1, dim=nrow(data))){
  rowsum(data[,columns], grouping)
}
groupwise.sum.fun(pros.dat)

# (c) Use `...` to revise the `groupwise.fun` function in (b) to allow us to use the `na.rm` option 
# of the function `rowsum()` to handle missing values when needed. 
test <- pros.dat
test[2, 1:3] <- NA
head(test)
groupwise.sum.fun <- function(data, columns=1:ncol(pros.dat), grouping=array(1, dim=nrow(data)), ...){
  rowsum(data[,columns], grouping, ...)
}
groupwise.sum.fun(test, na.rm=TRUE)

a<-1
f <- function(a){
  function(x) x+a
}

################# Task 2: Free Variables ############### 
# Compare the following two code snippets and predict what would be the result of calling `f(5)` in both cases. Explain why.   
# (1)  
y <- 3
f <- function (x) {
  y <- 1
  g <- function (x) {
    (x + y) / 2
  }
  g(x) 
}
f(5)
# enclosing values of g: x=5, y=1
# return value of f(5) is g(5), which is 3

# (2)
y <- 3
f <- function (x) {
  y <- 1
  g(x) 
}
g <- function (x) {
  (x + y) / 2      
}
f(5)
# enclosing values of g: x=5, y=3
# return value of f(5) is g(5), which is 4


################# Task 3: Deep Assignment ############### 
# We define a function factory for creating counters that record the number of times a function has been called

new_counter <- function() {
  i <- 0
  function() {
    i <<- i + 1
    i
  }
}

# Then we create two counters by using this function factory as follows:

counter_1 <- new_counter()
counter_2 <- new_counter()

# Run the following R code:

counter_1()
counter_1()
counter_2()

# Please explain how these function counters work.







