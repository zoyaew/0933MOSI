# Rename this file to "Inclass_08_YourName.R", where YourName is changed to your own name.
# Name: zewahyu (Revision)
# ID:

library(tidyverse)

################### Topic 7 - Task 1: Plotting Basics ############
# (a) Read the code:
set.seed(0)
x <- runif(50, min = -2, max = 2); y <- x^3 + rnorm(50)
plot(x, y, type = "p")
plot(x, y, type = "b")
# Explain why does the `plot()` with `type = "p"` looks normal, but the `plot()` with `type = "b"` looks abnormal, having crossing lines?  
# since x is not sorted,
# the type="b" will connect x values to its next index's value
# which resulted in the line not going in one direction

# (b) Modify the code above so that the lines on the second plot do not cross.
y <- y[order(x)]
x <- x[order(x)]
plot(x, y, type = "b")

# (c) The `cex` argument can used to shrink or expand the size of the points that are drawn. 
# Plot `y` versus `x`, first with `cex` equal to 0.5 and then 2 (so, two separate plots). 
# Give titles "Shrunken points", and "Expanded points", to the plots, respectively.
plot(x, y, cex=0.5, main="Shrunken points")
plot(x, y, cex=2, main="Expanded points")

# (d) The `xlim` and `ylim` arugments can be used to change the limits on the x-axis and y-axis, repsectively. 
# Plot `y` versus `x`, with the x limit set to be from -1 to 1, and the y limit set to be from -5 to 5. 
# Assign x and y labels "Trimmed x" and "Trimmed y", respectively.
plot(x, y, xlim=c(-1,1), ylim=c(-5,5), xlab = "Trimmed x", ylab = "Trimmed y")

# (e) Again plot `y` versus `x`, only showing points whose x values are between -1 and 1. 
# But this time, define `x.trimmed` to be the subset of `x` between -1 and 1, 
# and define `y.trimmed` to be the corresponding subset of `y`. 
# Then plot `y.trimmed` versus `x.trimmed` without setting `xlim` and `ylim`
# Tips: use logical indexing to define `x.trimmed`, `y.trimmed`.
x.trimmed <- x[x>=-1 & x<=1]
y.trimmed <- y[x>=-1 & x<=1]
plot(x.trimmed, y.trimmed)

# (f) The `pch` argument controls the point type in the display. 
plot(1:18, 1:18, pch = 1:18)
# The above plot displays the first 18 marker types. 
# Plot `y` versus `x`, and repeat the following pattern for the displayed points: 
# a black empty circle, a blue filled circle, a black empty circle, a red filled circle.
# Tips: use strings "blue", "red", and "black" to specify colors.
plot(x, y, pch = c(1, 16), col = c("black", "blue", "black", "red"))


################ Topic 7 - Task 2: Adding Items ######################
# (a) Produce a scatter plot of `y` versus `x` (which contains empty black circles of `y` versus `x`), 
# and set the title and axes labels as you see fit. 
# Then overlay a scatter plot of `y2` versus `x2` on top of the plot, using the `points()` function, 
# where `x2` and `y2` are as defined below. In the call to `points()`, 
# set the `pch` and `col` arguments appropriately so that the overlaid points are drawn as filled blue circles. 
x <- sort(runif(50, min = -2, max = 2))
y <- x^3 + rnorm(50)
x2 <- sort(runif(50, min = -2, max = 2))
y2 <- x2^2 + rnorm(50)

plot(x, y, xlab = "x", ylab = "y", main = "Scatter Plot")
points(x2, y2, col="blue", pch = 16)

# (b) Starting with your solution code from (a), overlay a line plot of `y2` versus `x2` on top of the plot, using the `lines()` function. 
# In the call to `lines()`, set the `col` and `lwd` arguments so that the line is drawn in red, 
# with twice the normal thickness.
plot(x, y, xlab = "x", ylab = "y", main = "Scatter Plot")
points(x2, y2, col="blue", pch = 16)

lines(x2, y2, col = "red", lwd=2)

# (c) Starting with your solution code from (b), add a legend to the bottom right corner of the the plot using `legend()`. 
# The legend should display the text: "Cubic" and "Quadratic", with corresponding symbols: 
# an empty black circle and a filled blue circle, respectively. 
# Tips: `pch` and `col`.
plot(x, y, xlab = "x", ylab = "y", main = "Scatter Plot")
points(x2, y2, col="blue", pch = 16)
lines(x2, y2, col = "red", lwd=2)

legend("bottomright", legend = c("Cubic", "Quadratic"), pch = c(1,16), col=c("black", "blue"))

# (d) Produce a plot of `y` versus `x`, but with a "gray" rectangle (`rect()`) displayed underneath the points. 
# This rectangle has a lower left corner at `(-2, qnorm(0.1))`, and an upper right corner at `(2, qnorm(0.9))`. 
plot(x, y, type = "n", xlab = "x", ylab = "y", main = "Scatter Plot")
rect(-2, qnorm(0.1), 2, qnorm(0.9), col="gray", border=NA)
points(x, y)

# (e) Produce a plot of `y` versus `x`, but with a gray tube displayed underneath the points. 
# Specifically, this tube should fill in the space between the two curves defined by $y=x^3 \pm q$, 
# where $q$ is the 90th percentile of the standard normal distribution (i.e., equal to `qnorm(0.90)`).  
# Add a legend to the bottom right corner of the plot, with the text: "Data" and "Confidence band", 
# and corresponding symbols: an empty circle and a very thick gray line, respectively. 
plot(x, y, type = "n", xlab = "x", ylab = "y")
polygon(c(x, x), c(x^3-qnorm(0.9), x^3+qnorm(0.9)), col = "gray", density = 30, border = NA)
points(x, y)
legend("bottomright", legend=c("Data", "Confidence"), pch = c(1, NA), col = c("black", "gray"), lwd = c(NA, 10) )


############## Topic 7 - Task 3: Plotting Financial Time Series for Stock Prices ###########
weekly <- read_csv("weeklyprice.csv", col_names = TRUE, col_types = cols())  
weekly

# Plot time series of stock prices for the three companies with seperate curves, each having a different color. 
# Try to reproduce the plot given in the assignment description.
# Tips: use the following code to customize the axis representing calendar dates: 
# `axis.Date(side = 1,at = seq(min(molten$date), max(molten$date), by = "6 mon"), format = "%m-%Y",cex.axis = 0.7)`









