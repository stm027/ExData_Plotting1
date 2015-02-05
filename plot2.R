#The plot2 function imports data from "household_power_consumption.txt", 
#subsets it by date, and creates a .png line graph 
#of a date/time variable vs. Global Active Power

plot2 <-function () {
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

#Reduces Font Size to match example
par(cex=.75)

#Produces a line graph in the screen device and 
#copies it as a .PNG file

with(data.subset, 
     plot(DateTime, Global_active_power, 
          type = "l",
          xlab = "", 
          ylab = "Global Active Power (kilowatts)"))

dev.copy(png, file = "plot2.png")
dev.off()
}
