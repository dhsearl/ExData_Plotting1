library(tidyverse)


# download zip file containing data if it hasn't already been downloaded
zip_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "household_power_consumption.zip"

if (!file.exists(zipFile)) {
  download.file(zip_url, zipFile, mode = "wb")
}

## Get just the rows we need. Add Column Names.
datas <- read_delim(zipFile, delim = ";", na = "?", skip=66637, n_max=2880, col_names=F)
colnames(datas) <- read_delim(zipFile, n_max = 1, col_names=F,delim=";")

## Convert Dates
datas$Date <- as.Date(datas$Date, "%d/%m/%Y")
datas$Datetime <- strptime(paste(datas$Date, datas$Time), "%Y-%m-%d %H:%M:%S")


#plot1
png(filename = "plot1.png", width=480, height=480)
hist(datas$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
