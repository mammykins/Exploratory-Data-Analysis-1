#EDA Coursera 
#Course project 1
#plot 2


#SETUP
rm(list = ls()) #clear workspace
setwd("C://Users//mammykins//Google Drive//R///coursera//eda") #name of current wd

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
                select = c("Date", "Global_active_power", "Time"))  # select the columns I need
#TIDY
tidydata <- filter(mydata, Date == "2/2/2007" | Date == "1/2/2007") %>%  # select the days I need
  mutate(gap = as.numeric(Global_active_power)) %>%   # convert from character to numeric
  mutate(t = as.POSIXct(paste(Date,Time), format="%d/%m/%Y %H:%M:%S"))  # lubridate failed, use base

#OUTPUT
png(filename="plot1.png", width = 480, height = 480)

plot(tidydata$t, tidydata$gap, type ="l",
     ylab = "Global Active Power (kW)", xlab = "")

dev.off()
