library(chron)

#read raw data
housedata <- read.table("./household_power_consumption.txt", header=TRUE, sep = ";")

#extract required data
dataset <- subset(housedata, as.Date(Date, "%d/%m/%Y") == "2007-02-01" | as.Date(Date, "%d/%m/%Y") == "2007-02-02")

#convert data to correct data type for processing
thetimes = chron(dates = as.character(dataset$Date), times = as.character(dataset$Time), format=c('d/m/y','h:m:s'))
dataset$Date <- thetimes
dataset$Global_active_power <- as.numeric(as.character(dataset$Global_active_power))
dataset$Global_reactive_power <- as.numeric(as.character(dataset$Global_reactive_power))
dataset$Voltage <- as.numeric(as.character(dataset$Voltage))
dataset$Sub_metering_1 <- as.numeric(as.character(dataset$Sub_metering_1))
dataset$Sub_metering_2 <- as.numeric(as.character(dataset$Sub_metering_2))
dataset$Sub_metering_3 <- as.numeric(as.character(dataset$Sub_metering_3))

#output plots
par(mfrow = c(2,2), mar = c(4, 4, 2, 2), oma = c(0, 0, 0, 0))

#plot 1
with(dataset, plot(Date, Global_active_power, type="l", xaxt="n", xlab="", ylab="Global Active Power"))
axis(1, at = c(13545, 13546, 13547), labels = c("Thu", "Fri", "Sat"))

#plot 2
with(dataset, plot(Date, Voltage, type="l", xaxt="n", xlab="datetime", ylab="Voltage"))
axis(1, at = c(13545, 13546, 13547), labels = c("Thu", "Fri", "Sat"))

#plot 3
with(dataset, plot(Date, Sub_metering_1, type="l", xaxt="n", xlab="", ylab="Energy sub metering"))
points(x=dataset$Date, y=dataset$Sub_metering_2, col='red', type='l')
points(x=dataset$Date, y=dataset$Sub_metering_3, col='blue', type='l')
axis(1, at = c(13545, 13546, 13547), labels = c("Thu", "Fri", "Sat"))
legend("topright", lty = 1, bty = "n", xjust = 1, col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#plot 4
with(dataset, plot(Date, Global_reactive_power, type="l", xaxt="n", xlab="datetime"))
axis(1, at = c(13545, 13546, 13547), labels = c("Thu", "Fri", "Sat"))

dev.copy(png, width = 680, height = 520, file = "plot4.png")
dev.off()