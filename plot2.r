download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "household_power_consumption.txt", method = "curl")
powerdata <- read.table("household_power_consumption.txt", header = FALSE, sep = ";", na.strings = "?", skip = 2, col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

datetime <- as.vector(paste(powerdata$Date, powerdata$Time))
datetime <- as.POSIXct(datetime, format = "%d/%m/%Y %H:%M:%S")
powerdata$datetime <- datetime
powerdata[, 1] <- as.Date(powerdata[, 1], format = "%d/%m/%Y")
powerdatasubset <- subset(powerdata, powerdata$Date >= as.Date("2007-02-01", format = "%Y-%m-%d"))
powerdatasubset <- subset(powerdatasubset, powerdatasubset$Date <= as.Date("2007-02-02", format = "%Y-%m-%d"))

##plot2
par(mfrow = c(1,1))
with(powerdatasubset, plot(datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowats)"))
dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()
