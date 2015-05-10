download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "household_power_consumption.txt", method = "curl")
powerdata <- read.table("household_power_consumption.txt", header = FALSE, sep = ";", na.strings = "?", skip = 2, col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

datetime <- as.vector(paste(powerdata$Date, powerdata$Time))
datetime <- as.POSIXct(datetime, format = "%d/%m/%Y %H:%M:%S")
powerdata$datetime <- datetime
powerdata[, 1] <- as.Date(powerdata[, 1], format = "%d/%m/%Y")
powerdatasubset <- subset(powerdata, powerdata$Date >= as.Date("2007-02-01", format = "%Y-%m-%d"))
powerdatasubset <- subset(powerdatasubset, powerdatasubset$Date <= as.Date("2007-02-02", format = "%Y-%m-%d"))

##plot4
par(mfrow = c(2,2))
with(powerdatasubset, plot(datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))

with(powerdatasubset, plot(datetime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))

with(powerdatasubset, plot(datetime, Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering"))
points(powerdatasubset$datetime, powerdatasubset$Sub_metering_2, type = "l", col = "red")
points(powerdatasubset$datetime, powerdatasubset$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), col = c("black", "red", "blue"))

with(powerdatasubset, plot(datetime, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))

dev.copy(png, "plot4.png", width = 480, height = 480)
dev.off()
