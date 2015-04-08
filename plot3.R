library(chron)

#read raw data
housedata <- read.table("./household_power_consumption.txt", header=TRUE, sep = ";")

#extract required data
dataset <- subset(housedata, as.Date(Date, "%d/%m/%Y") == "2007-02-01" | as.Date(Date, "%d/%m/%Y") == "2007-02-02")

#convert data to correct data type for processing
thetimes = chron(dates = as.character(dataset$Date), times = as.character(dataset$Time), format=c('d/m/y','h:m:s'))
dataset$Date <- thetimes
dataset$Global_active_power <- as.numeric(as.character(dataset$Global_active_power))
dataset$Sub_metering_1 <- as.numeric(as.character(dataset$Sub_metering_1))
dataset$Sub_metering_2 <- as.numeric(as.character(dataset$Sub_metering_2))
dataset$Sub_metering_3 <- as.numeric(as.character(dataset$Sub_metering_3))

#output plots
with(dataset, plot(Date, Sub_metering_1, type="l", xaxt="n", xlab="", ylab="Energy sub metering"))
points(x=dataset$Date, y=dataset$Sub_metering_2, col='red', type='l')
points(x=dataset$Date, y=dataset$Sub_metering_3, col='blue', type='l')
axis(1, at = c(13545, 13546, 13547), labels = c("Thu", "Fri", "Sat"))
legend("topright", lty = 1, col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, width = 680, height = 520, file = "plot3.png")
dev.off()