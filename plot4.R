## Exploratory Data Assignment 1 - Plot 4

## this script uses a datafile household_power_consumption.txt which can be downloaded at the following
## url: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

## this R script assumes that the exdata-data-household_power_consumption.zip has been unzipped and the 
## household_power_consumption.txt is included in the current working directory

# Reading in the table
tabAll <- read.table("household_power_consumption.txt", sep=";", header = TRUE)
#head(tabAll)
#tail(tabAll)
#str(tabAll)

## to convert $Date from factor to date format
tabAll$Date <- as.Date(as.character(tabAll$Date), "%d/%m/%Y")

##subset based on date
date_ss<-subset(tabAll, as.Date(Date) >= "2007-02-01" & as.Date(Date) <= "2007-02-02")

## vector of columns to convert from factor to strings and factor to numeric
str_cols<-2:8
num_cols<-3:8

## convert factors to character strings
str(date_ss)
date_ss[str_cols]<-lapply(date_ss[str_cols], as.character)

## convert char strings to numeric
date_ss[num_cols]<-lapply(date_ss[num_cols], as.numeric)

## add a total sub metering column to the date_ss
date_ss$Energy_Sub_Metering<-rowSums(date_ss[,c(7:9)])

## Plot 4 GAP, Voltage, Energy sub metering, Global_reactive_power
par(mfrow=c(2, 2), mar=c(5, 4, 4, 2))  
with(date_ss, {
        
        ## plot 4.1 top left
        with(date_ss, plot(as.POSIXct(paste(date_ss$Date, as.character(date_ss$Time))), Global_active_power, type="l", 
                           xlab = "",
                           ylab = "Global Active Power"
        ))
        
        ## plot 4.2 top right
        with(date_ss, plot(as.POSIXct(paste(date_ss$Date, as.character(date_ss$Time))), Voltage, type="l", 
                           xlab = "datetime",
                           ylab = "Voltage"
        ))
        
        ## plot 4.3 bottom left
        with(date_ss, plot(as.POSIXct(paste(date_ss$Date, as.character(date_ss$Time))), Energy_Sub_Metering, type="n", 
                           xlab = "",
                           ylab = "Energy Sub Metering",
                           ylim = c(0, 40)
                           
        )) 
        
        legend("topright", inset = c(0.05, 0), bty = "n", cex = 0.4, col=c("black", "red", "blue"), lwd=c(1, 1, 1), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) 
        lines(as.POSIXct(paste(date_ss$Date, as.character(date_ss$Time))), date_ss$Sub_metering_1, col="black")
        lines(as.POSIXct(paste(date_ss$Date, as.character(date_ss$Time))), date_ss$Sub_metering_2, col="red")
        lines(as.POSIXct(paste(date_ss$Date, as.character(date_ss$Time))), date_ss$Sub_metering_3, col="blue")
        
        ## plot 4.4 bottom right
        with(date_ss, plot(as.POSIXct(paste(date_ss$Date, as.character(date_ss$Time))), Global_reactive_power, type="l", 
                           xlab = "datetime", lwd=0.4
                           
        ))
        
})


## save Plot 4 to png format
dev.copy(png,"plot4.png", width = 480, height = 480, bg = "transparent")
dev.off()