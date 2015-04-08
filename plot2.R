#plot 2
library(dplyr)

data <- read.table("household_power_consumption.txt",
                   sep = ";",
                   dec=".",
                   header=TRUE,
                   stringsAsFactors = FALSE,
                   na.strings="?",
                   colClasses=c(rep("character",2), rep("numeric",7))
)


date1 <- filter(data, data$Date == "1/2/2007")
date2 <- filter(data, data$Date == "2/2/2007")

neededdata <- rbind(date1, date2)

mergeddate <- within(neededdata, Date_Time <- paste(neededdata$Date, neededdata$Time, sep=" "))

mergeddate$Date_Time <- strptime(mergeddate$Date_Time, "%d/%m/%Y %H:%M:%S")

plot2data <- select(mergeddate, Date_Time, Global_active_power)

png(file="plot2.png")
plot(plot2data,
     type="l",
     xlab=NA,
     ylab = "Global Active Power (kilowatts)")
dev.off()


rm(list=ls())