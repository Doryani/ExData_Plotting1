url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" # nolint
if (!file.exists("dataset")) {
    my_file <- download.file(url = url, destfile = "dataset")
}
if (!file.exists("UCI HAR Dataset")) {
    unzip("dataset")
}

data <- read.table("./household_power_consumption.txt",
    sep = ";",
    na.strings = "?"
)
colnames(data) <- data[1, ]
dateddata <- data[data$Date %in% c("1/2/2007", "2/2/2007"), ]
datetime <- strptime(
    paste(dateddata$Date, dateddata$Time, sep = " "),
    "%d/%m/%Y %H:%M:%S"
)
sub_1 <- as.numeric(dateddata$Sub_metering_1)
sub_2 <- as.numeric(dateddata$Sub_metering_2)
sub_3 <- as.numeric(dateddata$Sub_metering_3)
activepower <- as.numeric(dateddata$Global_active_power)
reactivepower <- as.numeric(dateddata$Global_reactive_power)
voltage <- as.numeric(dateddata$Voltage)

png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

plot(datetime, activepower,
    type = "l", xlab = "",
    ylab = "Global Active Power", cex = 0.2
)

plot(datetime, voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(datetime, sub_1, type = "l", ylab = "Energy submeter", xlab = "")
lines(datetime, sub_2, type = "l", col = "red")
lines(datetime, sub_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    lwd = 2.5, col = c("black", "red", "blue"), bty = "o", border = "white"
)

plot(datetime, reactivepower,
    type = "l", xlab = "datetime",
    ylab = "Global_reactive_power"
)

dev.off()