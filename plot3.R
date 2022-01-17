library(tidyverse)

#Read in first 100 rows to understand data structure
initial<-read.table("household_power_consumption.txt", header=TRUE, sep = ";", na.strings="?", nrows=100)

#Assign the class of each variable
classes<-sapply(initial, class)

#Read in full data with assigned variable classes
hpc<-read.table("household_power_consumption.txt", header=TRUE, sep = ";", na.strings="?", colClasses= classes)

#Subset data by dates of interest 
hpc.2 <- hpc %>% filter(Date %in% c("1/2/2007", "2/2/2007"))

#Remove original data table to free space
rm(hpc)

#Convert Date column to class 'Date'
hpc.2$Date <- as.Date(hpc.2$Date, "%d/%m/%Y")

#Create a date/time variable from Date and Time
dateTime <- paste(hpc.2$Date, hpc.2$Time)

#Convert to DateTime class
hpc.2$DateTime <- as.POSIXct(dateTime)

#Energy submetering through time, by submeter
with(hpc.2, {
    plot(Sub_metering_1~DateTime, type="l",
         ylab="Energy sub metering", xlab="")
    lines(Sub_metering_2~DateTime, col='Red')
    lines(Sub_metering_3~DateTime, col='Blue')
})
legend("topright", col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, lwd=1)

#Export file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
