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

# Create histogram of Global Active Power in png file
png(file = "plot1.png")
with(data, hist(Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power"))
dev.off()
