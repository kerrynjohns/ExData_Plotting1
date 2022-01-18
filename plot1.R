library(tidyverse)

#Read in first 100 rows to understand data structure
initial<-read.table("household_power_consumption.txt", header=TRUE, sep = ";", na.strings="?", nrows=100)

#Assign the class of each variable
classes<-sapply(initial, class)

#Read in full data with assigned variable classes
hpc<-read.table("household_power_consumption.txt", header=TRUE, sep = ";", na.strings="?", colClasses= classes)

str(hpc)
head(hpc)

#Subset data by dates of interest 
hpc.2 <- hpc %>% filter(Date %in% c("1/2/2007", "2/2/2007"))

#Remove original data table to free space
rm(hpc)

#Convert Date column to class 'Date'
hpc.2$Date <- as.Date(hpc.2$Date, "%d/%m/%Y")

#Check
glimpse(hpc.2)

#Histogram of Global Active Power
hist(hpc.2$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")

#Export file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
