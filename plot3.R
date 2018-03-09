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

# Create plot of Sub metering 1/2/3 vs. Date/Time in png file
png(file = "plot3.png")
with(data, plot(dateTime, Sub_metering_1, type = "n", 
                 xlab = "", ylab = "Energy sub metering"))
with(data, lines(dateTime, Sub_metering_1))
with(data, lines(dateTime, Sub_metering_2, col = "red"))
with(data, lines(dateTime, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()