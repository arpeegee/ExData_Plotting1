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
data$Sub_metering_3 <- as.numeric(levels(data$Sub_metering_3))[data$Sub_metering_3]

DateTime <- as.POSIXlt(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
dataToBeUsed <- cbind(DateTime, data[, 3:9])

# restrict data
# dataToBeUsed <- subset(x = data,
#                        (data$Date >= "2007-02-01" & data$Date <= "2007-02-02"))
dataToBeUsed <- subset(x = dataToBeUsed,
                       (dataToBeUsed$DateTime >= "2007-02-01 00:00:00 CET" & dataToBeUsed$DateTime <= "2007-02-02 23:59:59 CET"))

# generate plot
plot(x = dataToBeUsed$DateTime,
     y = dataToBeUsed$Global_active_power,
     ylab = "Global Active Power (kilowatts)",
     xlab = "",
     axes = TRUE,
     type = "n")
lines(dataToBeUsed$Global_active_power ~ dataToBeUsed$DateTime)

# copy plot into PNG
dev.copy(png, file = "plot2.png")
dev.off()
