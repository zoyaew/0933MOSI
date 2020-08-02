# Rename this file to "Inclass_01_YourName.R", where `YourName` is changed to your own name.
# Name: zewahyu (Revision)
# ID:
################# Task 1: Creating sequences ############### 
# (a) Create a sequence of numbers from 3 to 12 in descending order, save it as variable `x`.
x <- 12:3
x

# (b) Create a sequence of numbers from 3 to 30 in increments of 3, save it as variable `y`.
y <- seq(3,30,3)
y

# (c) Create a sequence of all even numbers from 4 to 42 in descending order, 
# save it as variable `z`, then determine the type and length of `z`. 
z <- seq(42,4,-2)
z
typeof(z)
length(z)

# (d) Output the results of `x + z` and `y * z` and determine the type(s) of the product and the sum
x+z
typeof(x+z)

y*z
typeof(y*z)


################# Task 2: Coercion rules #####################
# Determine the type of the output of the following uses of `c()`:
# c(1, FALSE) -> integer
# c("R programming", 3390) -> character
# c(TRUE, 1e3L) -> integer
typeof(c(1, FALSE))


################## Task 3: Factors #########################
# (a) Create an ordered factor that will be printed by R as follows:
# [1] b b a c b a c a 
# Levels: c < b < a
task3 <- factor(c("b", "b", "a", "c", "b", "a", "c", "a"), levels = c("c", "b", "a"), ordered = TRUE)

# (b) Use the `table()` function to count the occurrences of `a`, `b`, and `c` in the factor created in (a).
table(task3)






