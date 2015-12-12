plot1<-function() {
        
        url_add = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        #Import sqldf library to read in the subset by a sql command
        library(sqldf)
        #Import the datasets library for the hist function
        library(datasets)
        
        #Create a temporary file, download, unzip and read in the data
        #subset by the dates of interest
        temp <- tempfile()
        download.file(url_add, temp, mode="wb")
        unzip(temp, overwrite=TRUE)

        hpc <- read.csv.sql("household_power_consumption.txt", 
                sql="select * from file WHERE Date IN ('1/2/2007','2/2/2007')",
                header=TRUE, sep=";")
        
        #Format the Date column as a Date object
        hpc$Date = as.Date(hpc$Date, "%d/%m/%Y")
        
        #Create a device graphics window with the width and height as 480 pixels
        dev.new(width=480, height=480)
        
        #Execute the histogram with the desired features in the new graphics
        #window
        with(hpc, hist(hpc$Global_active_power, main="Global Active Power",
                col = "red", xlab = "Global Active Power (kilowatts)"))

        dev.copy(png, "plot1.png")
        dev.off()
        
}