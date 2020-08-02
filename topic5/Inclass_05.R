# Rename this file to "Inclass_05_YourName.R", where YourName is changed to your own name.
# Name: zewahyu (Revision)
# ID:
################# Topic 4 - Task 3: Deep Assignment ############### 
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
environment(counter_1)   # for counter_1, the value of i is store in this address
environment(counter_2)   # for counter_2, the value of i is store in this address

# Run the following R code:
ls.str(environment(counter_1))
counter_1()
ls.str(environment(counter_1))  # value of i in counter_1's enclosing environment is updated to 1
counter_1()
ls.str(environment(counter_2))
counter_2()

# Please explain how these function counters work.
# the enclosing environment for counter_1 and counter_2 are different
# therefore, i variable in both environment are different
# when we run counter_1 once, the i value in its enclosing environment change from 0 to 1,
# then when we run counter_1 again, the i value change again from 1 to 2
# meanwhile, in counter_2's enclosing environment, the i value still stays 0
# when we execute counter_2, that's when the i value for counter_2 changes from 0 to 1


################# Topic 5 - Task 1: The Split-and-Apply Pattern and `tapply()` ############### 
# `strikes.csv` contains the data on the political economy of strikes.
strikes.df <- read.csv("strikes.csv") 
head(strikes.df)

# (a) Split `strikes.df` by country
strikes.by.country <- split(strikes.df, strikes.df$country)
head(strikes.by.country)

# (b) Compute country-level averages for unemployment rate
sapply(strikes.by.country, function(x) mean(x$unemployment))

# (c) Compute country-level averages for union density 
sapply(strikes.by.country, function(x) mean(x$density, na.rm=TRUE))

# (d) Compute multiple groupwise avarages
sapply(strikes.by.country, function(x) c(unemployment=mean(x$unemployment),
                                         inflation=mean(x$inflation),
                                         strike.volume=mean(x$strike.volume)) )

# (e) Compute multiple groupwise averages in a more compact way. 
sapply(strikes.df[c("unemployment", "inflation", "strike.volume")],
       function(x) tapply(x, strikes.df$country, mean))


################# Topic 5 - Task 2: `*apply()` Functions ############### 
# The dataset `rio` includes the official statistics on the 11,538 athletes (6,333 men and 5,205 women) 
# and 306 events at the 2016 Rio Olympic Games.
rio <- read.csv("rio.csv")
head(rio)

# (a) Use `sapply` and `tapply` to count each type of medals (gold, silver and bronze) for each country. 
# Name your result `medal_chart`.



# use `order()` function to sort countries in the medal chart first by gold, 
# second by silver, and last by bronze.



# (b) Among the countries that had zero medals, which had the most athletes? 
# And how many athletes was this? Wrtie code to answer the question.  








