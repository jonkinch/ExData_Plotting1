plot4 <- function() {
		temp <- tempfile() #creating temp file due to permissions error
		download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
		file <- unzip(temp) #unzip the file to file
		unlink(temp) #unload temp
		
		power <- read.table(file, header=T, sep=";") #load power
		power$Date <- as.Date(power$Date, format="%d/%m/%Y") #format date		
		PlotData <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),] #filter to two days
		PlotData$Global_active_power <- as.numeric(as.character(PlotData$Global_active_power)) #formatting
		PlotData$Global_reactive_power <- as.numeric(as.character(PlotData$Global_reactive_power)) #formatting
		PlotData$Voltage <- as.numeric(as.character(PlotData$Voltage)) #fromatting
		PlotData <- transform(PlotData, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S") #lots of formtting		
		PlotData$Sub_metering_1 <- as.numeric(as.character(PlotData$Sub_metering_1))
		PlotData$Sub_metering_2 <- as.numeric(as.character(PlotData$Sub_metering_2))
		PlotData$Sub_metering_3 <- as.numeric(as.character(PlotData$Sub_metering_3))

        par(mfrow=c(2,2)) #create a 2 by 2 plot area
        
        plot(df$timestamp,df$Global_active_power, type="l", xlab="", ylab="Global Active Power") #first plot
        plot(df$timestamp,df$Voltage, type="l", xlab="datetime", ylab="Voltage") #second plot
        plot(df$timestamp,df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering") #third plot
        lines(df$timestamp,df$Sub_metering_2,col="red")
        lines(df$timestamp,df$Sub_metering_3,col="blue")
        legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #formatting for third plot        
        plot(df$timestamp,df$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power") #fourth plot       
        dev.copy(png, file="plot4.png", width=480, height=480) #png file!
		cat("Plot4.png was saved to", getwd())
		graphics.off() #all encompassing off
}