## setup the url for downloading
dataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (file.exists("H:\\rawData\\household_power_consumption.zip")) {
  unzip(zipfile="H:\\rawData\\household_power_consumption.zip",exdir="H:\\rawData",overwrite = TRUE,unzip = "internal") 
} else {
  if (! (file.exists("H:\\rawData\\"))) {
    dir.create("H:\\rawData\\")
  }
  download.file(url=dataURL,destfile="H:\\rawData\\household_power_consumption.zip",method="wininet")
}

### Read data from the dates 2007-02-01 and 2007-02-02 only.
data <- read.table(file="H:\\rawData\\household_power_consumption.txt",sep=";",header=FALSE,na.strings="?",nrows=2880,skip=66637)
colnames(data) <- c("date","time","GlobalActivePower","GlobalReactivePower","Voltage","GlobalIntensity","SubMetering1","SubMetering2","SubMetering3")

## Cleaning the data and preparing data for plotting.
data$datetime <- strptime(paste(data$date,data$time, sep = " "), format = "%d/%m/%Y %H:%M:%S")
data$date <- as.Date(data$date,format="%d/%m/%Y")

## Plot the data and save the plot
png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2),mar = c(4, 4, 2, 1))
with(data, plot(y=GlobalActivePower,x=datetime, type = "n",xlab ="", ylab="Global Active Power"))
with(data, lines(y=GlobalActivePower,x=datetime))

with(data, plot(y=Voltage,x=datetime, type = "n",xlab ="datetime", ylab="Voltage"))
with(data, lines(y=Voltage,x=datetime))

with(data, plot(y=SubMetering1,x=datetime, type = "n",xlab ="", ylab="Energy sub metering"))
with(data, lines(y=SubMetering1,x=datetime,col="black"))
with(data, lines(y=SubMetering2,x=datetime,col="red"))
with(data, lines(y=SubMetering3,x=datetime,col="blue"))
legend("topright",lty="solid",col = c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

with(data, plot(y=GlobalReactivePower,x=datetime, type = "n",xlab ="datetime", ylab="Global_Reactive_Power"))
with(data, lines(y=GlobalReactivePower,x=datetime))


dev.off()
