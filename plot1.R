library(dplyr)
library(lubridate)

Data_link <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(Data_link, 'Electric power consumption.zip', method = 'curl')
unzip('Electric power consumption.zip')
raw <- read.table('household_power_consumption.txt', na.strings = '?', 
                  sep = ';', header = T, stringsAsFactors = F) %>% tbl_df

Date_filtered <- raw[grepl('^(1|2)/2/2007', raw$Date), ]
Date_filtered <- Date_filtered %>% mutate(Date_Time = paste(Date_filtered$Date, Date_filtered$Time, sep = ' '))
Date_filtered$Date_Time <- Date_filtered$Date_Time %>% dmy_hms

hist(Date_filtered$Global_active_power, col = 'violetred', 
     xlab = 'Global Active Power (kilowatts)', main = 'Global Active Power')        

dev.copy(png, file = 'plot1.png')
dev.off()
