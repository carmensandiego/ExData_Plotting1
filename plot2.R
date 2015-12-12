plot2<-function() {
        
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
        dev.new(width=480, height=480)
        
        #Execute a line plot and export as a png file
        with(hpc, plot(hpc$Date,hpc$Global_active_power, type="l",
                       xlab = "",
                       ylab = "Global Active Power (kilowatts)"))
        
        dev.copy(png, "plot2.png")
        dev.off()
        
}