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

#Plot 1
hist(HouseData$Global_active_power, 
     col="red", 
     main = "Global Active Power",
     xlab="Global Active Power (kilowatts)" 
)
dev.copy(png, file = "plot1.png")
dev.off()