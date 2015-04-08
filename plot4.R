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



GAPdata <- select(mergeddate, Date_Time, Global_active_power)

png(file="plot4.png", width=480, height=480)
par(mfcol=c(2,2))
plot(GAPdata,
     type="l",
     xlab=NA,
     ylab = "Global Active Power")


submeterdata <- select(mergeddate, Date_Time, Sub_metering_1, Sub_metering_2, Sub_metering_3)


plot(submeterdata$Date_Time, submeterdata$Sub_metering_1, 
     type="n",
     xlab=NA,
     ylab="Energy sub metering")
legend("topright",
       lty = 1,
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n",
       cex = 0.9)
lines(submeterdata$Date_Time, submeterdata$Sub_metering_1, type="l")
lines(submeterdata$Date_Time, submeterdata$Sub_metering_2, type="l", col="red")
lines(submeterdata$Date_Time, submeterdata$Sub_metering_3, type="l", col="blue")

voltatedata <- select(mergeddate, Date_Time, Voltage)

plot(voltatedata, 
     type="l", 
     xlab="datetime", 
     ylab="Voltage")

GRPdata <- select(mergeddate, Date_Time, Global_reactive_power)

plot(GRPdata,
     type="l",
     xlab="datetime",
     ylab="Global_reactive_power")



dev.off()

