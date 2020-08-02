# Rename this file to "Inclass_03_YourName.R", where YourName is changed to your own name.
# Name: zewahyu (Revision)
# ID:
################# Task 1:  If Else Statements ############### 
# Inspect the outputs of the two code snippets below and explain how they work.
# a)
x <- 1:10
if (length(x)) "not empty" else "empty"
# Explanation: 
# length(x) is 10
# as.logical(10) is T
# return "not empty"

# b)
x <- numeric()
if (length(x)) "not empty" else "empty"
# Explanation: 
# x is numeric(0)
# length(x) is 0
# return "empty"


################# Task 2: switch() ############### 
# Rewrite the following code snippet with `switch()` (`stop()` stops execution and throws an error):
x = "a"   # can be other values
if (x == "a") {
  "option 1"
} else if (x == "b") {
  "option 2" 
} else if (x == "c") {
  "option 3"
} else {
  stop("Invalid `x`` value")
}
x = "a"
switch(x, a = "option 1", b = "option 2", c = "option 3", stop("Invalid x value"))


################# Task 3: Grade Assignement ############### 
# Run the following code snippet to generate a sequence of random numbers.   
set.seed(0)
scores <- round(runif(50, 45, 100), 1)
scores

# (a) Suppose that these numbers represent students' scores of a course. 
# Write a `for` loop to convert these numbers to letter grades. 
# The letter grade will be "A" if a score is at least 90. 
# The letter grade will be "B" if a score  is between 80 and 90. 
# The letter grade will be "F" if a score is lower than "80". 
# Create a variable called `grades` to store the result.
grades = character()
for(i in seq_along(scores)){
  if(scores[i] >= 90){
    grades[i] <- "A"
  } else if(scores[i] >= 80){
    grades[i] <- "B"
  } else{
    grades[i] <- "F"
  }
}
grades

# (b) Use `ifelse()` to do the same thing with a single line of code.  
grades = character()
for(i in seq_along(scores)){
  grades[i] <- ifelse(scores[i] >= 90, "A",
               ifelse(scores[i] >= 80, "B", "F"))
}
grades


################# Task 4: Least Common Multiple ###############
# Suppose that an arbitraty number of values are stored in a vector named `find.lcm`.
# Use conditionals and/or loops to find the least common multiple for values in this vector.
# For example, for `find.lcm <- c(4, 5, 7)`, this code should yield 140; 
# for `find.lcm <- c(3, 5, 7, 23)`, this code should return 2415; 
# for `find.lcm <- 2:14`, this code should yield 360360.
find.lcm <- c(2,3,4)
answer <- 0
sum <- 1
while(sum!=0){
  sum <- 0
  answer <- answer+1
  for(input in seq_along(find.lcm)){
    sum <- sum + answer%%find.lcm[input]
  }
  if(sum == 0) print(answer)
}

################# Task 5: Groupwise data summarization ###############
setwd("C:/Users/LENOVO/Downloads/ISOM3390/topic3")
pros.dat <- read.table("pros.dat")
str(pros.dat) 
head(pros.dat)

set.seed(0)
grouping <- sample(1:10, size = 97, replace = T)
grouping

# (a) Write a `for` loop (possibly nested) to caclualate the groupwise sum of each column. 
# Store the result in a **10 by 9** (10 groups and 9 columns) matrix called `groupwise.sum`.
groupwise.sum <- matrix(0, nrow=10, ncol=9)
for(col in 1:9){
  for(row in 1:10){
    groupwise.sum[row, col] <- sum(pros.dat[grouping==row, col])
  }
}
groupwise.sum

# (b) Convert the `pros.dat` data frame to a matrix called `pros.mat` using the following code:
pros.mat <- as.matrix(pros.dat)
# Then write a `for` loop to do the same thing. Now you only need a flat loop with `colSums()`.
groupwise.sum <- matrix(0, nrow=10, ncol=9)
for(group in 1:10){
  groupwise.sum[group, ] <- colSums(pros.dat[grouping==group,])
}
groupwise.sum

# (c) Figure out how to use a function named `rowsum()` with `pros.mat` to achieve the same goal.
groupwise.sum <- rowsum(pros.mat, grouping)
groupwise.sum