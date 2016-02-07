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
data$Date <- as.Date(strptime(data$Date, format = "%d/%m/%Y"))
data$Global_active_power <- as.numeric(levels(data$Global_active_power))[data$Global_active_power]

# restrict data
dataToBeUsed <- subset(x = data,
                       (data$Date >= "2007-02-01" & data$Date <= "2007-02-02"))

# generate plot
hist(x = dataToBeUsed$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     col = "red",
     xlim = c(0, 6),
     ylim = c(0, 1200),
     axes = FALSE)
axis(side = 1,
     at = seq(0, 6, 2),
     labels = seq(0, 6, 2))
axis(side = 2,
     at = seq(0, 1200, 200),
     labels = seq(0, 1200, 200))

# copy plot into PNG
dev.copy(png, file = "plot1.png")
dev.off()
