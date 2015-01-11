setwd("H:/My Documents/ExploreData/Project1")

HouseData <- read.table("H:/My Documents/ExploreData/household_power_consumption/household_power_consumption.txt", header= TRUE, sep = ";")
HouseData$Date <- as.Date(HouseData$Date, format = "%d/%m/%Y")
HouseData <- HouseData[HouseData$Date>="2007-02-01"&HouseData$Date<="2007-02-02",]
DateTime <- as.POSIXct(paste(HouseData$Date,HouseData$Time))
HouseData$DateTime <- DateTime
HouseData$DateTime <- strptime(HouseData$DateTime, format = "%Y-%m-%d %H:%M:%S")
HouseData <- HouseData[,3:10]
for(i in 1:7) {
  HouseData[,i] <- as.numeric(as.character(HouseData[,i]))
}


#write.table(HouseData, "HousePowerConsumption.txt",sep = "\t")
#HouseData <- read.table("HousePowerConsumption.txt",sep = "\t", header = TRUE)

#Plot 4
par(mfrow = c(2,2))
# Section 1

#Plot 2
plot(type="l", 
     x = HouseData$DateTime, 
     y = HouseData$Global_active_power,
     xlab = "",
     ylab="Global Active Power"
)
# Section 2
plot(type="l", 
     x = HouseData$DateTime, 
     y = HouseData$Voltage,
     xlab = "datetime",
     ylab="Voltage"
)
# Section 3
yrange <- range(c(HouseData$Sub_metering_1,HouseData$Sub_metering_2,HouseData$Sub_metering_3))
plot(type="l", 
     x = HouseData$DateTime,
     xlab = "",
     y = HouseData$Sub_metering_1,
     ylim = yrange,
     ylab="Energy sub metering",
)

par(new=TRUE)
plot(type="l", 
     x = HouseData$DateTime,
     xlab = "",
     y = HouseData$Sub_metering_2,
     ylim = yrange,
     ylab="Energy sub metering",
     col = "red"
)

par(new=TRUE)
plot(type="l", 
     x = HouseData$DateTime,
     xlab = "",
     y = HouseData$Sub_metering_3,
     ylim = yrange,
     ylab="Energy sub metering",
     col = "blue"
)
par(new = FALSE)
legend("topright",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"), 
       lwd = 1, lty=1, bty = "n", cex = 0.75, #y.intersp = 0.4, inset = 0
       # The above commented-out code can be uncommented for correcting problems
       # introduced in RStudio
)
# Section 4
plot(type="l", 
     x = HouseData$DateTime, 
     y = HouseData$Global_reactive_power,
     xlab = "datetime",
     ylab="Global_reactive_power"
)

# PNG Creation
dev.copy(png, file = "plot4.png")
dev.off()