#plot1.R
library(dplyr)

data <- read.table("household_power_consumption.txt",
                   sep = ";",
                   dec=".",
                   header=TRUE,
                   stringsAsFactors = FALSE,
                   na.strings="?",
                   colClasses=c(rep("character",2), rep("numeric",7))
)

date1 <- filter(data, Date == "1/2/2007")
date2 <- filter(data, Date == "2/2/2007")

neededdata <- rbind(date1, date2)
rm(data, date1, date2)

neededdata$Date <- weekdays(as.Date(neededdata$Date, format="%d/%m/%Y"))

png(file="plot1.png")
hist(neededdata$Global_active_power,
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
dev.off()

rm(list=ls())
