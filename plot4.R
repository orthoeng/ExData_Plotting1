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
## 5. Construct the 4 subplots - Global Active Power, Voltage, Energy sub metering and Global Reactive Power

          Global_Active_Power = as.numeric(rangedate$Global_active_power) ## Make Global_active_power numeric

              par(mfrow = c(2,2))

                  plot(Global_Active_Power ~ rangedate$Datetime, type="l", ylab = "Global Active Power", xlab = "") 

                  plot(rangedate$Voltage ~ rangedate$Datetime, type="l", ylab = "Voltage", xlab = "datetime") 

                  plot(rangedate$Sub_metering_1 ~ rangedate$Datetime, type="l", ylab = "Energy sub metering", xlab = "") 
                        lines(rangedate$Sub_metering_2 ~ rangedate$Datetime, col= 2)
                        lines(rangedate$Sub_metering_3 ~ rangedate$Datetime, col= 4)
                        legend("topright", lty = 1, col = c(1, 2, 4), y.intersp = 0.8, legend = c("Sub_metering_1",
                                            "Sub_metering_2", "Sub_metering_3"))

                  plot(rangedate$Global_reactive_power ~ rangedate$Datetime, type="l", ylab = "Global_reactive_power", 
                                              xlab = "datetime") 

##########################################################################################################
## 6. Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
## Name each of the plot files as plot4.png

          dev.copy(png, file="plot4.png", height=480, width=480) ## save to file
          dev.off() ## close file
