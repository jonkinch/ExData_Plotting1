plot1 <- function() {
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
        hist(PlotData$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)") #create bar chart
        dev.copy(png, file="plot1.png", width=480, height=480) #copy the bar chart
        cat("Plot1.png was saved to", getwd()) #notify that we created the png file
		#dev.off(which = dev.next()) #clears the plot area in RStudio.  clearing the current one would clear the png one I think so we're clearing the next one (Screen).
		graphics.off() #all encompassing off
}