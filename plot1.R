library(chron)

#read raw data
housedata <- read.table("./household_power_consumption.txt", header=TRUE, sep = ";")

#extract required data
dataset <- subset(housedata, as.Date(Date, "%d/%m/%Y") == "2007-02-01" | as.Date(Date, "%d/%m/%Y") == "2007-02-02")

#convert data to correct data type for processing
dataset$Global_active_power <- as.numeric(as.character(dataset$Global_active_power))

#output histogram
hist(dataset$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

dev.copy(png, file = "plot1.png")
dev.off()