library(chron)

#read raw data
housedata <- read.table("./household_power_consumption.txt", header=TRUE, sep = ";")

#extract required data
dataset <- subset(housedata, as.Date(Date, "%d/%m/%Y") == "2007-02-01" | as.Date(Date, "%d/%m/%Y") == "2007-02-02")

#convert data to correct data type for processing
thetimes = chron(dates = as.character(dataset$Date), times = as.character(dataset$Time), format=c('d/m/y','h:m:s'))
dataset$Date <- thetimes
dataset$Global_active_power <- as.numeric(as.character(dataset$Global_active_power))

#output plot
with(dataset, plot(Date, Global_active_power, type="l", xaxt="n", xlab="", ylab="Global Active Power (kilowatts)"))
axis(1, at = c(13545, 13546, 13547), labels = c("Thu", "Fri", "Sat"))

dev.copy(png, file = "plot2.png")
dev.off()