# Rename this file to "Inclass_02_YourName.R", where `YourName` is changed to your own name.
# Name: zewahyu (Revision)
# ID:
################## Task 4: Matrices ##########################
# (a) Define a variable `x.vec` to contain the integers 1 through 100. 
# Add up the numbers in `x.vec`, by calling a built-in R function `sum()` (`?sum`)
x.vec <- 1:100
sum(x.vec)

# (b) Convert `x.vec` into a matrix with 20 rows and 5 columns (filled columnwise), and store this as `x.mat`. 
# Check the dimensions of `x.mat`, and the data type as well. 
# Compute the sums of each of the 5 columns of `x.mat`, by calling a built-in R function `colSums()`  (`?colSums`). 
x.mat <- matrix(x.vec, nrow = 20, ncol = 5)
dim(x.mat)
typeof(x.mat)
colSums(x.mat)

# (c) Extract and display rows 1, 5, and 17 of `x.mat`, with a single line of code. 
# 1. How many elements in row 2 of `x.mat` are larger than 40? 
# 2. How many elements in column 3 are in between 45 and 50? 
# 3. How many elements in column 5 are odd? 
x.mat[c(1,5,17),]
sum(x.mat[2,]>40)
sum(x.mat[,3]>45 & x.mat[,3]<50)
sum(x.mat[,5]%%2==1)

################## Task 5: Lists #########################################
# (a) Construct a nested list that will be printed as follows by `str()`. 
# Name the resulting list `x.list`.

# List of 3
# $ :List of 3
# ..$ : num [1:2] 2.3 5.9
# ..$ : Factor w/ 2 levels "a","b": 1 2 2 1 1
# ..$ : logi [1:3] TRUE FALSE TRUE
# $ :List of 1
# ..$ :List of 1
# .. ..$ : int [1:3] 1 2 3
# $ : int [1:2, 1:3] 20 17 19 16 18 15
list1 <- list(c(2.3, 5.9), factor(c("a","b","b","a","a")), c(T,F,T))
list2 <- list(list(seq(1,3)))
list3 <- (matrix(20:15, 2, 3, byrow = T))
x.list <- list(list1, list2, list3)
str(x.list)


# (b) Complete the following tasks, each with a single line of code.
# 1. Extract all but the 2nd first-level list element of `x.list` - seeking here a list as the final answer.
x.list[-2]
str(x.list[-2])

# 2. Use a **single pair** of double brackets `[[ ]]` to extract the only factor and output the following
# [1] a b b a a
# Levels: a b
x.list[[c(1,2)]]

# 3. Extract the last 2 columns of the matrix and output the following:
#      [,1] [,2]
# [1,]   19   18
# [2,]   16   15
x.list[[3]][,c(2,3)]


################## Task 6: Data frame - cars data ##########################
# We'll use a very simple dataset to see how we can perform simple data processing and visualization. 
# We're going to use the `cars` data that comes with the default installation of R and is 
# maintained as a data frame object.  

head(cars, n=10)
cars$speed  
cars$dist   

# (a) Calculate the average (`mean()`) and standard deviation (`sd()`) of speed and distance.
attach(cars)
mean(speed)
sd(speed)
mean(dist)
sd(dist)

# (b) Normalize the `dist` data by subtracing individual values by mean and dividing the 
# results by standard deviation.
(dist-mean(dist))/sd(dist)

# (c) Select all even values greater than 50 in the `dist` column using Boolean indexing.
cars[dist%%2==0 & dist>50, "dist"]
detach(cars)


################## Task 7: Data frame - survey data ##########################
# In this task, we're going to import an external dataset and explore it. 
# The dataset `survey.csv` (csv is short for comma-separated values) can be downloaded from Canvas.

setwd("C:/Users/LENOVO/Downloads/ISOM3390/topic2")
survey = read.table("survey.csv", header = TRUE, sep = ",")   # return a data frame

# (a) Use `head()` and `tail()` to pick the first and last 5 respondents. 
# Combine them together and display the result.
head(survey, n=5)
tail(survey, n=5)
rbind(head(survey, n=5), tail(survey, n=5))

# (b) Apply `typeof()`, `class()`, `str()`, `length()`, and `dim()` to `survey`.
typeof(survey)
class(survey)
str(survey)
length(survey)
dim(survey)

# (c) Write code to determine how many survey respondents are from MARK or FINA.
attach(survey)
sum(Program=="MARK" | Program=="FINA")

# (d) Write code to determine what percentage of survey respondents are from IS.
sum(Program=="IS") / nrow(survey)

# (e) Use `$` and `[]`  notation to pull the `OperatingSystem` column from the survey data.  
survey$OperatingSystem
survey[,"OperatingSystem"]

# (f) Change the column name `Program` to `Major`.
names(survey)[1] <- "Major"

# (g) Use `table()` to determine the distributions of levels of `Rexperience` among 
# respondents from different `Major`s.
table(Major, Rexperience)

# (h) Write code to get the `Major` and `Rexperience` of every student who watched 
# at least 15 hours of TV (`TVhours`).
survey[TVhours>=15,c("Major","Rexperience")]

# (i) Write code to sort survey respondents by `TVhours` in descending order.
survey[order(TVhours, decreasing=T),]
detach(survey)