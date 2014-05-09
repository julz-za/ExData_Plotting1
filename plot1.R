## Exploratory Data Assignment 1 - Plot 1

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

## Plot 1 histogram Global Active Power
hist(date_ss$Global_active_power, 
     main = "Global Active Power",
     cex.main = 0.9,
     col = "red", 
     xlab = "Global Active Power (kilowatts)",
     cex.lab = 0.8
)

## save Plot 1 to png format
dev.copy(png,"plot1.png", width = 480, height = 480, bg = "transparent")
dev.off()
