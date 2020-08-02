# Rename this file to "Inclass_09_YourName.R", where YourName is changed to your own name.
# Name: zewahyu (Revision)
# ID:

default <- read.csv("Default.csv", nrow = 200)
################### Topic 7 - Task 3: Plotting Histograms #########################
# Use `par(new = TRUE)` to create the same plot (two histograms) as the one created by the following code:
hist(default$balance, col = "pink", freq = FALSE, xlab = "Balance", main = "Histogram of Balance")
hist(default$balance + 400, col = rgb(0, 0.5, 0.5, 0.5), freq = FALSE, add=TRUE)

hist(default$balance, col = "pink", freq = FALSE, xlab = "Balance", main = "Histogram of Balance and Balance + 400", xlim = c(0,2400))
par(new = TRUE)
hist(default$balance + 400, col = rgb(0, 0.5, 0.5, 0.5), freq = FALSE, main=NA, xlab=NA, ylab=NA, xlim = c(0,2400))


################### Topic 7 - Task 4: Plotting Stock Prices #########################
weekly <- read_csv("weeklyprice.csv", col_names = TRUE, col_types = cols())  
weekly

# Plot time series of stock prices for the three companies with seperate curves, 
# each having a different color. 
weekly_l <- pivot_longer(weekly, -1, names_to = "Date")

plot(as.Date(filter(weekly_l, company=="FB")$Date), filter(weekly_l, company=="FB")$value, 
     xlab = "Date", ylab = "Closing Price", main = "Time Series of Stock Prices", 
     type="l", col="red", ylim=c(0,max(weekly_l$value)), axes = FALSE)
par(new=TRUE)
plot(as.Date(filter(weekly_l, company=="GOOG")$Date), filter(weekly_l, company=="GOOG")$value, 
     type = "l", col="blue", xlab = NA, ylab = NA, ylim=c(0,max(weekly_l$value)), axes = FALSE)
par(new=TRUE)
plot(as.Date(filter(weekly_l, company=="AMZN")$Date), filter(weekly_l, company=="AMZN")$value, 
     type = "l", col="green", xlab = NA, ylab = NA, ylim=c(0,max(weekly_l$value)), axes = FALSE)
box()
legend("topleft", legend = c("FB", "GOOG", "AMZN"), lty = 1, col = c("red", "blue", "green"))
axis.Date(side = 1, at = seq(min(as.Date(weekly_l$Date)), max(as.Date(weekly_l$Date)), by = "6 mon"), format =
            "%m-%Y", cex.axis = 0.7)
axis(side=2, at = seq(0, max(weekly_l$value), by=200), cex.axis=0.7)


######################## Topic 8 - Task 1: Plotting Billboard Ranking ###########################
library(tidyverse)

billboard <- read_csv("billboard.csv")  
billboard_sample <- billboard %>% select(-c(3:6, 39:70)) %>% 
  filter(artist %in% c("Eminem", "3 Doors Down", "Carey, Mariah", "Creed", "Aaliyah"))
billboard_sample

# (a) Convert `billboard_sample` to long format. Name the new tibble `billboard_long`.
billboard_long <- pivot_longer(billboard_sample, c(-1,-2), names_to = "week", names_prefix = "week", values_to = "position", 
                               names_ptypes = list(week = factor()), values_drop_na = TRUE)
billboard_long

# (b) Create a plot to show how the ranking positions of these 11 songs vary across weeks. 
# Use a distinct color for each song.
ggplot(billboard_long, mapping = aes(week, position, colour = track)) +
  geom_line(aes(group = track), size = 1, alpha = 0.5) +
  scale_y_reverse() +
  theme(legend.position = "top")

# (c) Modify the code above to use different colors to represent songs of different aritists. 
ggplot(billboard_long, mapping = aes(week, position, colour = artist)) +
  geom_line(aes(group = track), size = 1, alpha = 0.5) +
  scale_y_reverse() +
  theme(legend.position = "top")


################# Topic 8 - Task 2: Plotting Billboard Ranking, Continued ###############
# (a) Use `stat_summary()` to display the best weekly records for each artist; 
# that is, the highest position her/his songs have reached for each week after release. 
ggplot(billboard_long, mapping = aes(week, position, color = artist)) +
  stat_summary(geom = "line", fun = max, aes(group = artist), size = 1, alpha = 0.5) +
  scale_y_reverse() +
  theme(legend.position = "top")

# (b) Use the `billboard_long` tibble to create a box plot to show the distribution of weekly 
# ranking positions of all songs, and overlay the best weekly records for each of the 5 artists on it.
ggplot(billboard_long, mapping = aes(week, position)) +
  geom_boxplot(aes(group = week)) +
  stat_summary(geom = "line", fun = max, aes(group = artist, color = artist), size = 1, alpha = 0.5) +
  scale_y_reverse() +
  theme(legend.position = "top")

