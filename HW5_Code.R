
# Question 1
library(tidyverse)
library(grep)
library(plyr)


setwd("F:/SMU/DS6306/HW5")

df <- read.csv("yob2016.txt", header = FALSE, sep = ";")

names(df) <- c("names", "gender", "amount")

str(df)

summary(df)

grep("yyy$", df$names)  # locate the record with yyy at the end

df[212,]  # display the name

y2016 <- df[-212,] 

# Question 2
setwd("F:/SMU/DS6306/HW5")

y2015 <- read.csv("yob2015.txt", header = FALSE, sep = ",")

tail(y2015,10) # last 10 rows have the same number of children

names(y2015) <- c("names", "gender", "amount")

## inner join to remove duplication - the question in the HW introduces duplication if gender is not added as a by statement
final <- merge(y2015, y2016, by=c("names", "gender"))


# check if NA values exist
sum(is.na(final$amount.x))
sum(is.na(final$amount.y))

# Question 3

# add a total column that sums both columms
final$total <- final$amount.x + final$amount.y

sum(final$total) # how many people were given popular names?

sortFinal <- final[order(-final$total),] # sort the data
head(sortFinal,10) # top 10 most popular names
FFinal <- subset(sortFinal, gender == "F") # only return females
FFinal <- head(FFinal,10) # top 10 most popular names
FFinal <- FFinal[,c("names","total")]

getwd()
write.csv(FFinal, file = "FemaleNamesTop10.csv")
