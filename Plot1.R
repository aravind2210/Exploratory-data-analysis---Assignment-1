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

## plot1
hist(tidy_data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
 
