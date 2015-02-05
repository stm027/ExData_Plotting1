#The plot4 function imports data from "household_power_consumption.txt", 
#subsets it by date, and creates a .png plot with four graphs
#1. A date/time variable vs. Global Active Power
#2. A date/time variable vs. Voltage
#3. A date/time variable vs. Three Submetering variables
#4. A date/time variable vs. Global Reactive Power

plot4 <-function () {
#Reads the .txt file in as a dataframe "data"
#composed of character vectors

data<-read.table(
  "household_power_consumption.txt", 
  header = TRUE, sep =";", colClasses = "character")


#Combines Date and Time into DateTime and formats as POSIXlt

data$DateTime<-paste(data$Date,data$Time)
data$DateTime <- strptime(
  data$DateTime, format("%d/%m/%Y %H:%M:%S"))

#Reformats the Date column into a date format 

data$Date<-as.Date(data$Date, format("%d/%m/%Y"))

#Subsets "data" to "data.subset" for the required timespan

DATE1 <- as.Date("2007-02-01")
DATE2 <- as.Date("2007-02-02")
data.subset<-subset(data, Date == DATE1 | Date == DATE2)
rm(data)

#Formats remaining "data.subset" as numerics

data.subset[[3]]<-as.numeric(data.subset[[3]])
data.subset[[4]]<-as.numeric(data.subset[[4]])
data.subset[[5]]<-as.numeric(data.subset[[5]])
data.subset[[6]]<-as.numeric(data.subset[[6]])
data.subset[[7]]<-as.numeric(data.subset[[7]])
data.subset[[8]]<-as.numeric(data.subset[[8]])
data.subset[[9]]<-as.numeric(data.subset[[9]])

#Adjusts parameters to match example
par(mfrow= c(2,2))
par(cex=.6)

#Creates first plot

with(data.subset, 
     plot(DateTime, Global_active_power, 
          type = "l",
          xlab = "", 
          ylab = "Global Active Power"))

#Creates second plot

with(data.subset, 
     plot(DateTime, Voltage, 
          type = "l",
          xlab = "datetime", 
          ylab = "Voltage"))

#Creates third plot
with(data.subset, 
     plot(DateTime, Sub_metering_1, 
          type = "l",
          xlab = "",
          ylab = "Energy sub metering"))

with(data.subset, 
     lines(DateTime, Sub_metering_2, 
           col = "red"))

with(data.subset, 
     lines(DateTime, Sub_metering_3, 
           col = "blue"))

legend("topright", 
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col = c("black","red","blue"), 
       lwd = 1,
       bty = "n")

#Creates fourth plot

with(data.subset, 
     plot(DateTime, Global_reactive_power, 
          type = "l",
          xlab = "datetime", 
          ylab = "Global_reactive_power"))

dev.copy(png, file = "plot4.png")
dev.off()
}
