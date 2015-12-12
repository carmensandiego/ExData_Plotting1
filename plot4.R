plot4<-function() {
        
        url_add = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        #Import sqldf library to read in the subset by a sql command
        library(sqldf)
        #Import the datasets library for the hist function
        library(datasets)
        
        library(lubridate)
        
        #Create a temporary file, download, unzip and read in the data
        #subset by the dates of interest
        temp <- tempfile()
        download.file(url_add, temp, mode="wb")
        unzip(temp, overwrite=TRUE)
        
        hpc <- read.csv.sql("household_power_consumption.txt", 
                            sql="select * from file WHERE Date IN ('1/2/2007','2/2/2007')",
                            header=TRUE, sep=";")
        
        #Format the Date column as a Date object
        hpc$Date = dmy_hms(paste(hpc$Date, hpc$Time))
        
        #Create a device graphics window with the width and height as 480 pixels
        png(filename="plot4.png", width=480, height=480)
        
        par(mfrow = c(2,2))
        
        #Execute 4 plots in one png file
        with(hpc, {plot(hpc$Date,hpc$Global_active_power, type="l",
                        xlab = "",
                        ylab = "Global Active Power")
                plot(hpc$Date,hpc$Voltage, type="l",
                     xlab = "datetime",
                     ylab = "Voltage")
                plot(hpc$Date,hpc$Sub_metering_1, type="l",
                       xlab = "",
                       ylab = "Energy Sub Metering")
                with(hpc, lines(hpc$Date, hpc$Sub_metering_2, col="red"))
                with(hpc, lines(hpc$Date, hpc$Sub_metering_3, col="blue"))
                legend("topright", c("Sub_metering_1", "Sub_metering_2",
                        "Sub_metering_3"), lty=1, lwd=2, bty="n",
                        col=c("black", "red", "blue"), cex=0.8)
                plot(hpc$Date,hpc$Global_reactive_power, type="l",
                     xlab = "datetime",
                     ylab = "Global_reactive_power")
        })
        
        dev.off()
        
}