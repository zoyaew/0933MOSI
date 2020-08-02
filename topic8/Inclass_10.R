# Rename this file to "Inclass_10_YourName.R", where YourName is changed to your own name.
# Name: zewahyu (Revision)
# ID:

library(tidyverse)
#install.packages("maps")
library("maps")

################## Topic 8 - Task 3: Plotting Multiple Lines ##################################
# (a) Convert the data frame `mpg` to a long format `mpg_l`, 
# where the column `type` indicates whether the record is `cty` or `hwy`, 
# and the column `miles` stores the corresponding value of `cty` or `hwy`. 
mpg_l <- pivot_longer(mpg, c("cty", "hwy"), names_to = "type", values_to = "miles")
mpg_l

# (b) Use `mpg_l` to reproduce the same plot created by the following code using `mpg`.
ggplot(mpg, aes(displ)) + geom_line(aes(y = cty, colour = "cty")) + 
  geom_line(aes(y = hwy, colour = "hwy")) + 
  scale_colour_manual(values = c("cty" = "red", "hwy" = "green"))

ggplot(mpg_l, aes(displ)) + geom_line(aes(y=miles, colour = type)) +
  scale_colour_manual(values = c("cty" = "red", "hwy" = "green"))


################### Topic 8 - Task 4: Population Density Heatmap of Hong Kong #########################
hk_mapdata <- read_csv("hk_mapdata.csv")
hk_mapdata

# (a) Find out how many polygons the "Islands" district contains, 
# and how many polygons the "Sha Tin" district contains.
hk_mapdata %>% filter(District=="Islands") %>% .$Polygon %>% unique %>% length
hk_mapdata %>% filter(District=="Sha Tin") %>% .$Polygon %>% unique %>% length

# (b) Use `geom_polygon()` to plot the boundary of the "Sha Tin" district
ggplot(hk_mapdata %>% filter(District=="Sha Tin"), aes(X, Y)) + geom_polygon()

# (c) Use `geom_polygon()` to plot the boundary of the "Islands" district.   
ggplot(hk_mapdata %>% filter(District=="Islands"), aes(X, Y, group = Polygon)) + geom_polygon()

# (d) Use `geom_polygon()` to plot the boundary of all 18 districts. 
table(hk_mapdata$Polygon, hk_mapdata$District)
ggplot(hk_mapdata, aes(X, Y, group = interaction(Polygon, District))) + geom_polygon()

# (e) Load the data "hk_districts.csv" and create a tibble named `hk_districts`.
hk_districts <- read_csv("hk_districts.csv")
hk_districts
# Merge the tibbles `hk_mapdata` and `hk_districts` in order to add district information to `hk_mapdata`.
hk_mapdata <- inner_join(hk_mapdata, hk_districts)
hk_mapdata

# (f) Create the population density heatmap using the augmented tibble produced in (e).
ggplot(hk_mapdata, aes(Long, Lat, group = interaction(District, Polygon) )) + geom_polygon(aes(fill = Density))

# (g) Create a heatmap for comparing total populations of different districts.
ggplot(hk_mapdata, aes(Long, Lat, group = interaction(District, Polygon) )) + geom_polygon(aes(fill = Population))
# the result is different because hk_mapdata$Density is a discrete variable because it's stored in characters,
# while hk_mapdata$Population is continuous because it's stored as numeric


############ Topic 8 - Task 5: Population Density Heatmap of Hong Kong, Continued ###########
# Reverse the colour gradient using `scale_fill_gradient()`
# Remove axis labels 
# Add a title to the plot, put it in the middle (instead of on the left)
# Change the position of legend to the top
# Change the legend label and title
# Change the background color to white using `theme_bw()`
ggplot(hk_mapdata, aes(Long, Lat, group = interaction(District, Polygon) )) + geom_polygon(aes(fill = Population)) +
  labs(x = NULL, y = NULL, title = "Hong Kong Population by 18 Districts") +
  scale_fill_gradient("Population\n(in ten thousand)", low = "#56B1F7", high = "#132B43", labels = c(20, 30, 40, 50, 60)) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5), legend.position = "top", legend.key.width = unit(1.8, "cm"))






