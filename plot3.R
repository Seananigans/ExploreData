#Set your working directory with the Dataset
setwd("H:/My Documents/ExploreData")

HouseData <- read.table("./household_power_consumption/household_power_consumption.txt", 
                        header= TRUE, sep = ";")
HouseData$Date <- as.Date(HouseData$Date, format = "%d/%m/%Y")
HouseData <- HouseData[HouseData$Date>="2007-02-01"& 
                               HouseData$Date<="2007-02-02",]
DateTime <- as.POSIXct(paste(HouseData$Date,HouseData$Time))
HouseData$DateTime <- DateTime
HouseData$DateTime <- strptime(HouseData$DateTime, format = "%Y-%m-%d %H:%M:%S")
HouseData <- HouseData[,3:10]
for(i in 1:7) {
        HouseData[,i] <- as.numeric(as.character(HouseData[,i]))
}

# Create a new Dataset with the necessar values for this analysis
#write.table(HouseData, "HousePowerConsumption.txt",sep = "\t")
#HouseData <- read.table("HousePowerConsumption.txt",sep = "\t", header = TRUE)

#Plot 3
yrange <- range(c(HouseData$Sub_metering_1,HouseData$Sub_metering_2,HouseData$Sub_metering_3))
plot(type="l", 
     x = HouseData$DateTime,
     xlab = "",
     y = HouseData$Sub_metering_1,
     ylim = yrange,
     ylab="Energy sub metering",
)
legend("topright",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"), 
       lwd = 1, cex=0.75, lty=1, y.intersp = 1
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


dev.copy(png, file = "plot3.png")
dev.off()