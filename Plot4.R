library(dplyr)
library(lubridate)
##downloading and unzipping the file in the working directory.
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "ea1.zip")
zipF<-file.choose() # lets you choose a file and save its file path in R (at least for windows)
outDir<- ("exploratory analysis") # Define the folder where the zip file should be unzipped to 
unzip(zipF,exdir=outDir)

dt <- read.table(".//exploratory analysis//household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE)

## extract the data containing only the respective dates ("1/2/2007","2/2/2007")
extract <- subset(dt, dt$Date %in% c("1/2/2007","2/2/2007")) 
strp_time <- strptime(paste(extract$Date, extract$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
tidy_data <- cbind(strp_time,extract)
tidy_data <- tidy_data[,-c(2,3)] ##deleting the columns (Date,Time) from the data set.

##plot4

par(mfrow = c(2,2), mar = c(4,4,2,2))

with(tidy_data, plot(strp_time, Global_active_power, type = "l",xlab = "", ylab = "Global Active Power (kilowatts)"))

plot(tidy_data$strp_time, tidy_data$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")

plot(tidy_data$strp_time, tidy_data$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "" )
lines(tidy_data$strp_time,tidy_data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "") 
lines(tidy_data$strp_time, tidy_data$Sub_metering_2, type = "l", col = "red", ylab = "Energy sub metering", xlab = "")
lines(tidy_data$strp_time, tidy_data$Sub_metering_3, type = "l", col = "blue", ylab = "Energy sub metering", xlab = "")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty = c(1,1,1), cex = 0.5)

plot(tidy_data$strp_time,tidy_data$Global_reactive_power,type = "l", xlab = "datetime", ylab = "Global_reactive_power")
