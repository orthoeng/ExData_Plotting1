########################################################################################################

rm(list=ls(all=TRUE))
library(dplyr)

########################################################################################################
## 1. Load data to a table from household_power_consumption.txt file.

          electric_power_data <- read.table("household_power_consumption.txt", sep = ";", as.is = TRUE, header = TRUE)

########################################################################################################    
## 2. Make Date string to an object - format Year - Month - Day 

          electric_power_data$Date <- as.Date(electric_power_data$Date, format="%d/%m/%Y")

########################################################################################################
## 3. Select 2-days 2007-02-01 and 2007-02-01 from the large dataset 

          cutdata  <- electric_power_data %>% filter(Date == "2007-02-01")  ## find 2007-02-01 cut from dataset
          cutdata1  <- electric_power_data %>% filter(Date == "2007-02-02") ## find 2007-02-02 cut from dataset
          rangedate <- rbind(cutdata, cutdata1) ## row bind the two sets together     

#########################################################################################################
## 4. X - Axis day and time range  

          datetime <- paste(as.Date(rangedate$Date), rangedate$Time)
          rangedate$Datetime <- as.POSIXct(datetime) ## Add in time format 

#########################################################################################################
## 5. Construct a line plot 
## Title = "Global Active Power", X-Axis = "Thu, Fri, Sat", Y-Axis = "Global Active Power (kilowatts)"

          Global_Active_Power = as.numeric(rangedate$Global_active_power) ## Make Global_active_power numeric
          plot(Global_Active_Power ~ rangedate$Datetime, type="l", ylab = "Global Active Power (kilowatts)", xlab = "") 

##########################################################################################################
## 6. Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
## Name each of the plot files as plot2.png

          dev.copy(png, file="plot2.png", height=480, width=480) ## save to file
          dev.off() ## close file
