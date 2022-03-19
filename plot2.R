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
activepower <- as.numeric(dateddata$Global_active_power)
png("plot2.png", width = 480, height = 480)
plot(datetime, activepower,
    type = "l", xlab = "",
    ylab = "Global Active Power (kilowatts)"
)
dev.off()