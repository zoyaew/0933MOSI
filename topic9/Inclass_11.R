# Rename this file to "Inclass_11_YourName.R", where YourName is changed to your own name.
# Name: zewahyu (Revision)
# ID:

library(tidyverse)

#################### Task 1: String Operations #####################
# (a) Consider the string vector `presidents` of length 5 below, 
# containing the last names of past US presidents. 
# Convert the first letter of each name in `presidents` to upper case. 
presidents <- c("trump", "obama", "bush", "clinton", "bush")
str_to_title(presidents)

# (b) Consider the string `presidents` defined below. 
# Use `str_split()` to split this string up into a string vector of length 5, 
# with elements "Trump", "Obama", "Bush", "Clinton", and "Bush". 
# Then, sort the names in alphabetical (increasing) order and 
# use `str_c()` to combine this string vector into a single string 
# "Bush -> Bush -> Clinton -> Obama -> Trump". 
presidents <- "Trump, Obama, Bush, Clinton, Bush"
presidents %>% str_split(", ") %>% unlist %>% sort %>% str_c(collapse = " -> ")


############# Task 2: Shakespeare's Works ###############################
shakespeare.lines <- read_lines("shakespeare.txt")
shakespeare.lines[1:5]  

# (a) Queries about `shakespeare.lines`:
# 1. How many lines are there? 
# 2. How many characters are there in the longest line? 
# 3. What is the average number of characters per line? 
# 4. How many lines are there with zero characters (empty string)? 
shakespeare.lines %>% length #147838
shakespeare.lines %>% str_length %>% max #78
shakespeare.lines %>% str_length %>% mean #37.50825
shakespeare.lines %>% str_length %>% {sum(.==0)} #17744
    
# (b) Remove all empty lines from `shakespeare.lines`. 
# Collapse the lines in `shakespeare.lines` into one big string, 
# separating each line by a space in doing so, using `str_c()`. 
# Call the resulting string `shakespeare.all`. How many characters does this string have?
shakespeare.all <- shakespeare.lines %>% {str_c(.[str_length(.)!=0], collapse = " ")}
shakespeare.all %>% str_length #5675237

# (c) Split up `shakespeare.all` into words, using `str_split()` with `pattern = " +"`. 
# Call the resulting string vector (note: here we are asking you for a vector, not a list) `shakespeare.words`. 
# Use the `unique()` function to compute and store the unique words as `shakespeare.words.unique`. 
# How many unique words are there?  
(shakespeare.words <- shakespeare.all %>% str_split(pattern = " +") %>% unlist)
shakespeare.words.unique <- shakespeare.words %>% unique
length(shakespeare.words.unique) #76170
    
# (d) Print the top 5 longest words in `shakespeare.words.unique`. 
# Do you recognize any of these as actual words?
shakespeare.words.unique %>% str_length %>% order(decreasing = T) %>%
  {shakespeare.words.unique[.][1:5]}
# Ans: No

# (e) Using `table()`, compute counts for the words in `shakespeare.words`, 
# and save the result as `shakespeare.wordtab`. 
# Use name indexing to answer: how many times does the word "rumour" appear? 
# The word "gloomy"? The word "assassination"?
shakespeare.wordtab <- table(shakespeare.words)
shakespeare.wordtab[c("rumour","gloomy","assassination")] #7, 3, 1 respectively

# (f) Sort `shakespeare.wordtab` so that its entries (counts) are in decreasing order, 
# and save the result as `shakespeare.wordtab.sorted`. 
# Print the 25 most commonly used words, along with their counts. 
shakespeare.wordtab.sorted <- shakespeare.wordtab %>% sort(decreasing = T)
shakespeare.wordtab.sorted[1:25]


##################### Task 3: Shakespeare's Works, Continued ######################
# (a) There are a couple of issues with the way we've built our words in `shakespeare.words`. 
# The first one is that capitalization matters 
# The second issue is that many words contain punctuation marks 
shakespeare.wordtab[c("and", "And", "and,")]

# Fix these two issues. Start from `shakespeare.all`, split it into words, 
# call the resulting string vector `shakespeare.words.new`. 
# Then, delete all empty strings from this vector, and compute word table from it, called `shakespeare.wordtab.new`. 
shakespeare.words.new <- shakespeare.all %>% {str_split(str_to_lower(.), pattern = "[[:space:]]|[[:punct:]]")} %>% unlist
shakespeare.words.new <- shakespeare.words.new %>% .[str_length(.)!=0]
shakespeare.wordtab.new <- table(shakespeare.words.new)

# (b) Compute the unique words in `shakespeare.words.new`, call the result `shakespeare.words.new.unique`. 
# Then print the top 5 longest words in `shakespeare.words.new.unique`.
shakespeare.words.new.unique <- unique(shakespeare.words.new)
shakespeare.words.new.unique[order(str_length(shakespeare.words.new.unique), decreasing = T)][1:5]

# (c) Sort `shakespeare.wordtab.new` so that its entries (counts) are in decreasing order, 
# and save the result as `shakespeare.wordtab.sorted.new`. 
# Print out the 25 most common words and their counts.  
shakespeare.wordtab.sorted.new <- sort(shakespeare.wordtab.new, decreasing = T)
shakespeare.wordtab.sorted.new[1:25]

