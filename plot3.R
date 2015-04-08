#plot 3

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

plot3data <- select(mergeddate, Date_Time, Sub_metering_1, Sub_metering_2, Sub_metering_3)

png(file="plot3.png")
plot(plot3data$Date_Time, plot3data$Sub_metering_1, 
     type="n",
     xlab=NA,
     ylab="Energy sub metering")
legend("topright",
       lty = 1,
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       cex = 0.9)
lines(plot3data$Date_Time, plot3data$Sub_metering_1, type="l")
lines(plot3data$Date_Time, plot3data$Sub_metering_2, type="l", col="red")
lines(plot3data$Date_Time, plot3data$Sub_metering_3, type="l", col="blue")
dev.off()
