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

png("plot3.png", width = 480, height = 480)
plot(datetime, sub_1,
    type = "l", xlab = "",
    ylab = "Energy submetering"
)
lines(datetime, sub_2, col = "red")
lines(datetime, sub_3, col = "blue")
legend(
    x = "topright",
    legend = c("sub_metering_1", "sub_metering_2", "sub_metering_3"),
    col = c("black", "red", "blue"), lwd = 2
)
dev.off()