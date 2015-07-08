#EDA Coursera 
#Course project 1
#plot 3


#SETUP
rm(list = ls()) #clear workspace
#setwd("") #name of current wd

#LIBRARY - check if packages are installed and load them
if(!require("dplyr")) {
  install.packages("dplyr")
  require("dplyr")
}

if(!require("lubridate")) {
  install.packages("lubridate")
  require("lubridate")
}

if(!require("data.table")) {
  install.packages("data.table")
  require("data.table")
}

#INPUT
mydata <- fread(input = "housepower.txt",
                #nrows = 0, #check variable names beforehand if big file!
                na.strings = "?",
                select = c("Date", "Global_active_power", "Time", 
                           "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))  # select the columns I need
#TIDY
tidydata <- filter(mydata, Date == "2/2/2007" | Date == "1/2/2007") %>%  # select the days I need
  mutate(sub1 = as.numeric(Sub_metering_1),
         sub2 = as.numeric(Sub_metering_2),
         sub3 = as.numeric(Sub_metering_3)) %>%   # convert from character to numeric
  mutate(t = as.POSIXct(paste(Date,Time), format="%d/%m/%Y %H:%M:%S")) # lubridate failed, use base

#OUTPUT
png(filename="plot3.png", width = 480, height = 480)

plot(tidydata$t, tidydata$sub1, type="n", xlab="",
     ylab="Energy sub metering")  # EMPTY PLOT then add lines
lines(tidydata$t, tidydata$sub1, col="black")
lines(tidydata$t, tidydata$sub2, col="red")
lines(tidydata$t, tidydata$sub3, col="blue")
legend("topright", lty=1, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"))

dev.off()
