# Download data, if needed
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipname <- "ElecPower.zip"
filename <- "household_power_consumption.txt"

if (!file.exists(filename)) {
        download.file(fileURL, zipname)
        unzip(zipname)
}

# Read data into R, set column classes
data <- read.csv2(filename, na.strings = "?", dec = ".", skip = 66636, nrow = 2880, 
                  colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

# Set column names
colnames <- read.csv2(filename, na.strings = "?", nrow = 1)
colnames(data) <- colnames(colnames)

# Merge Date and Time columns
dateTime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
data <- cbind(dateTime, data, stringsAsFactors = FALSE)

# Create plot of Global Active Power vs. Date/Time in png file
png(file = "plot2.png")
with(data, plot(dateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()
