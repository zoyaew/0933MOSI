library(tidyverse)
library(rvest)


#Example 1
webpage <- read_html("https://www.nytimes.com/interactive/2017/06/23/opinion/trumps-lies.html")
webpage
results <- html_nodes(webpage, ".short-desc")
results

results[1]
date <- html_nodes(results[1], "strong") %>% html_text(trim=T)
lie <- xml_contents(results[1])[2] %>% html_text(trim=T) %>% str_sub(2,-2)
explanation <- xml_contents(results[1])[3] %>% html_text(trim=T) %>% str_sub(2,-2)
url <- html_nodes(results[1], "a") %>% html_attr("href")


for(i in seq_along(results)){
  date[i] <- html_nodes(results[i], "strong") %>% html_text(trim=T)
  lie[i] <- xml_contents(results[i])[2] %>% html_text(trim=T) %>% str_sub(2,-2)
  explanation[i] <- xml_contents(results[i])[3] %>% html_text(trim=T) %>% str_sub(2,-2)
  url[i] <- html_nodes(results[i], "a") %>% html_attr("href")
}

records <- tibble(date, lie, explanation, url)



#Example 2
historical_prices<- read_html("https://finance.yahoo.com/quote/%5EGSPC/history?p=%5EGSPC") %>% html_nodes("table") %>% html_table(header = TRUE) %>% .[[1]] %>% as_tibble()
historical_prices



str(write_csv)
write_csv(records, "trump_lies.csv")
str(read_csv)
read_csv("trump_lies.csv")
