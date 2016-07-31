{
## load the data.table package so that the fread function can be used
library(data.table)

## set the working directory to the location of the data
setwd("~/R Studio/data")

## read in the data from the text file
mydata<-fread("./Plotting/household_power_consumption.txt",na.strings="?")

## convert the Date field to a date class
mydata$Date<-as.Date(mydata$Date,"%d/%m/%Y")

## create a subset of the data that contains only the first two days of Feb 2007
newdata <- mydata[ which(mydata$Date=='2007-02-01'| mydata$Date=="2007-02-02"), ]

## combine the Date and Time variables into one field and format as POSIXct
newdata$newdate <- with(newdata, as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"))

## convert the variables used in the plotting exercise to numeric
newdata$Global_active_power<-as.numeric(newdata$Global_active_power)
newdata$Sub_metering_1<-as.numeric(newdata$Sub_metering_1)
newdata$Sub_metering_2<-as.numeric(newdata$Sub_metering_2)
newdata$Sub_metering_3<-as.numeric(newdata$Sub_metering_3)
newdata$Voltage<-as.numeric(newdata$Voltage)
newdata$Global_reactive_power<-as.numeric(newdata$Global_reactive_power)

## create a png file and populate it with plot 3 from the assignment 
png(file="plot3.png",width=480,height=480)
plot(newdata$newdate,newdata$Sub_metering_1,type="l",xlab=NA,ylab="Energy sub metering")
lines(newdata$newdate,newdata$Sub_metering_2,type="l",col="red")
lines(newdata$newdate,newdata$Sub_metering_3,type="l",col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"))
dev.off()
}