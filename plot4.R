# pre-process: download and unzip file
# Assumption: "ExData_Plotting1" folder is present

if (!file.exists("./ExData_Plotting1/exdata-data-household_power_consumption.zip")){
  print("File not there, proceed to download")
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="./ExData_Plotting1/exdata-data-household_power_consumption.zip", mode="wb")
}

if (!file.exists("./ExData_Plotting1/household_power_consumption.txt")){
  print("Extracted file not found, proceed with unzip")
  unzip("./ExData_Plotting1/exdata-data-household_power_consumption.zip", exdir="./ExData_Plotting1")
}

print("Data preparation")
#data <- read.table("./ExData_Plotting1//household_power_consumption.txt", sep=";", nrows = 50, header=TRUE)
BaseData <- read.table("./ExData_Plotting1/household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors = FALSE, na.strings = "?")
#Convert Date
BaseData$Date <- as.Date(BaseData$Date, format="%d/%m/%Y")
data <- subset(BaseData, subset = (Date >="2007-02-01" & Date <= "2007-02-02"))
#Clean up BaseData
rm(BaseData)
#Append DateTime to new Column
date_time <- paste(as.Date(data$Date), data$Time)
data$DateTime <- as.POSIXct(date_time)
print("Data Preparation done")

#Prepare graph
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

plot(data$Global_active_power~data$DateTime, type="l", ylab = "Global Active Power", xlab="")

plot(data$Voltage~data$DateTime, type="l", ylab="Voltage", xlab="")

plot(data$Sub_metering_1~data$DateTime, type = "l", ylab = "Energy sub metering", xlab = "")
lines(data$Sub_metering_2~data$DateTime, col="Red")
lines(data$Sub_metering_3~data$DateTime, col="Blue")
legend("topright", col=c("black","red","blue"), bty="n", lty=1, lwd=2, legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

plot(data$Global_reactive_power~data$DateTime, type="l", ylab="Global_reactive_power", xlab="")

dev.copy(png, file = "./ExData_Plotting1/plot4.png", height = 480, width = 480)
dev.off()
