#set directory to where your data is stored
 

plot4fun <- function() {
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
        png(filename = "plot4.png", width = 480, height = 480)
        
        #set parameters of plot
        par(mfrow = c(2, 2))
        
        #first plot
        with(datasub, plot(DateTime, Global_active_power,
                type = "l",
                ylab = "Global Active Power",
                xlab = ""))
        
        #second plot
        with(datasub, plot(DateTime, Voltage,
                type = "l",
                xlab = "datetime"))
        
        #third plot
        with(datasub, plot(DateTime, Sub_metering_1,
                type = "l",
                ylab = "Energy sub metering",
                xlab = ""))
        with(datasub, lines(DateTime, Sub_metering_2, col = "red"))
        with(datasub, lines(DateTime, Sub_metering_3, col = "blue"))
        legend("topright", legend = names(datasub)[7:9], lty = c(rep(1,3)), col = c("black", "red", "blue"), 
                bty = "n")
        
        #fourth plot
        with(datasub, plot(DateTime, Global_reactive_power,
                type = "l",
                xlab = "datetime"))
        
        dev.off()
}
