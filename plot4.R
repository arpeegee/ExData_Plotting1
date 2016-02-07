# code for first plot

# URL of data source
dataurl <- "https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip"

# download and store file
download.file(url=dataurl,
              destfile = "./data/household_power_consumption.zip")
dateDownloaded <- date()

# unzip file
unzipped <- unzip(zipfile = "./data/household_power_consumption.zip",
                  exdir = "data")

# read in data
data <- read.csv(file = "./data/household_power_consumption.txt",
                 sep = ";")

# reformat data
# data$Date <- as.Date(strptime(data$Date, format = "%d/%m/%Y"))
# data$Time <- as.numeric(levels(data$Time))[data$Time]
data$Global_active_power <- as.numeric(levels(data$Global_active_power))[data$Global_active_power]
data$Global_reactive_power <- as.numeric(levels(data$Global_reactive_power))[data$Global_reactive_power]
data$Voltage <- as.numeric(levels(data$Voltage))[data$Voltage]
data$Sub_metering_1 <- as.numeric(levels(data$Sub_metering_1))[data$Sub_metering_1]
data$Sub_metering_2 <- as.numeric(levels(data$Sub_metering_2))[data$Sub_metering_2]
# data$Sub_metering_3 <- as.numeric(levels(data$Sub_metering_3))[data$Sub_metering_3]

DateTime <- as.POSIXlt(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
dataToBeUsed <- cbind(DateTime, data[, 3:9])

# restrict data
# dataToBeUsed <- subset(x = data,
#                        (data$Date >= "2007-02-01" & data$Date <= "2007-02-02"))
dataToBeUsed <- subset(x = dataToBeUsed,
                       (dataToBeUsed$DateTime >= "2007-02-01 00:00:00 CET" & dataToBeUsed$DateTime <= "2007-02-02 23:59:59 CET"))

# set parameters for multiple plots
par(mfrow = c(2, 2))

# generate first plot
plot(x = dataToBeUsed$DateTime,
     y = dataToBeUsed$Global_active_power,
     ylab = "Global Active Power",
     xlab = "",
     axes = TRUE,
     type = "n")
lines(dataToBeUsed$Global_active_power ~ dataToBeUsed$DateTime)

# generate second plot
plot(x = dataToBeUsed$DateTime,
     y = dataToBeUsed$Voltage,
     ylab = "Voltage",
     xlab = "datetime",
     axes = TRUE,
     type = "n")
lines(dataToBeUsed$Voltage ~ dataToBeUsed$DateTime)

# generate third plot
plot(x = dataToBeUsed$DateTime,
     y = dataToBeUsed$Sub_metering_1,
     ylab = "Energy sub metering",
     xlab = "",
     axes = TRUE,
     type = "n")
lines(dataToBeUsed$Sub_metering_1 ~ dataToBeUsed$DateTime, col = "black")
lines(dataToBeUsed$Sub_metering_2 ~ dataToBeUsed$DateTime, col = "red")
lines(dataToBeUsed$Sub_metering_3 ~ dataToBeUsed$DateTime, col = "blue")
legend("topright",
       legend = c("Sub_meter_1", "Sub_meter_2", "Sub_meter_3"),
       col = c("black", "red", "blue"),
       lty = "solid", lwd = 1, bty = "n")

# generate forth plot
plot(x = dataToBeUsed$DateTime,
     y = dataToBeUsed$Global_reactive_power,
     ylab = "Global_reactive_power",
     xlab = "datetime",
     axes = TRUE,
     type = "n")
lines(dataToBeUsed$Global_reactive_power ~ dataToBeUsed$DateTime)

# copy plot into PNG
dev.copy(png, file = "plot4.png")
dev.off()
