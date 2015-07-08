#EDA Coursera 
#Course project 1
#plot 1


#SETUP
rm(list = ls()) #clear workspace
setwd("") #name of current wd

#LIBRARY - check if packages are installed and load them
if(!require("dplyr")) {
  install.packages("dplyr")
  require("dplyr")
}

if(!require("lubridate")) {
  install.packages("lubridate")
  require("lubridate")
}

if(!require("ggplot2")) {
  install.packages("ggplot2")
  require("ggplot2")
}

if(!require("data.table")) {
  install.packages("data.table")
  require("data.table")
}

#INPUT
mydata <- fread(input = "housepower.txt",
                #nrows = 0, #check variable names beforehand if big file!
                na.strings="?",
                select = c("Date", "Global_active_power"))

mydata <- mutate(mydata, date = dmy(mydata$Date)) # convert character to POSIX class

tidydata <- filter(mydata, date >= ymd("2007/02/01") & date <= ymd("2007/02/02")) # seelct the two day period we want
tidydata$Global_active_power <- as.numeric(tidydata$Global_active_power)

#OUTPUT
png(filename="plot1.png", width = 480, height = 480)

hist(tidydata$Global_active_power,
     main = "Global Active Power", ylab = "Frequency", xlab = "Global active power (kW)",
     col = "red"
)
mtext("Plot1", side = 3)

dev.off()
