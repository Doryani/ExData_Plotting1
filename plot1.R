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

activepower <- as.numeric(dateddata$Global_active_power)
png("plot1.png", width = 480, height = 480)
hist(activepower,
    col = "red", main = "Global Active Power",
    xlab = "Global Active Power (kilowatts)"
)
dev.off()