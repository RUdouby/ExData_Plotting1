#set directory to where your data is stored
 

plot2fun <- function() {
        #read in the data
        classes <- c(rep("character", 2), rep("numeric", 7))
        data1 <- read.table("household_power_consumption.txt", sep = ";", header = T, colClasses = classes, 
                stringsAsFactors = F, na.strings = "?")
        
        #want to combine the date and time columns
        data1$DateTime <- paste(data1$Date, data1$Time)
        data1$DateTime <- strptime(data1$DateTime, format = "%d/%m/%Y %H:%M:%S")
        
        #subset data to 
        datasub <- data1[grep("^1/2/2007$|^2/2/2007$", data1$Date), ]
        
        #plot
        png(filename = "plot2.png", width = 480, height = 480)
        with(datasub, plot(DateTime, Global_active_power,
                type = "l",
                ylab = "Global Active Power (kilowatts)",
                xlab = ""))
        dev.off()
}
