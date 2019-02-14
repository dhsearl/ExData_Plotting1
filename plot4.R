library(readr)


# download zip file containing data if it hasn't already been downloaded
zip_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "household_power_consumption.zip"

if (!file.exists(zipFile)) {
  download.file(zip_url, zipFile, mode = "wb")
}

# Get just the rows we need. Add column names.
datas <- read_delim(zipFile, delim = ";", na = "?", skip=66637, n_max=2880, col_names=F)
colnames(datas) <- read_delim(zipFile, n_max = 1, col_names=F,delim=";")

# Convert Dates and create Datetime column.
datas$Date <- as.Date(datas$Date, "%d/%m/%Y")
datas$datetime <- strptime(paste(datas$Date, datas$Time), "%Y-%m-%d %H:%M:%S")


# plot1 Not Used
#png(filename = "plot1.png", width=480, height=480)
#hist(datas$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
#dev.off()


# plot4 parameters & graphics device initialization
png(filename = "plot4.png", width=480, height=480)
par(mfcol=c(2,2))

# Top Left - plot 2
plot(datas$datetime, datas$Global_active_power, type="l", ylab = "Global Active Power (kilowatts)",xlab="")

# Bottom Left - plot3 
with(datas, plot(datetime, Sub_metering_1, type="n", ylab="Energy sub metering", xlab=""))
lines(datas$datetime, datas$Sub_metering_1, col=1)
lines(datas$datetime, datas$Sub_metering_2, col=2)
lines(datas$datetime, datas$Sub_metering_3, col=4)
legend("topright",lty=c(1,1,1),col=c(1,2,4), lwd=c(2,2,2),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n")

# Top Right - plot4.1 
with(datas, plot(datetime, Voltage, type="l"))

# Bottom Right - plot4.2 
with(datas, plot(datetime, Global_reactive_power,type="l"))

dev.off()
