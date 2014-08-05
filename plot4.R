# read file as lines for performance:
fname <- "household_power_consumption.txt"
lns <- readLines(fname)

# keep only header line (first) and lines with date 2007-02-01 or 2007-02-02 (as per instruction)
linesToKeep<-c(1,grep(lns,pattern="^1/2/2007|^2/2/2007"))
lns <- lns[linesToKeep]


# define a helper functions for formating of the date and time in source
setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )

setClass('myTime')
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )

# read the lines parsed into a data.frame named data
data <- read.table(text=lns,
                   sep = ";", 
                   header=T, 
                   quote="", 
                   na.strings = "?", 
                   stringsAsFactors=FALSE,
                   comment.char="", 
                   #nrows = 100,
                   colClasses=c("myDate","character","numeric", "numeric","numeric","numeric", "numeric","numeric","numeric")
)

# add column for DateTime:
dateTimeVector <- apply( data[,1:2] , 1, paste ,collapse = " " )
data$DateTime <- as.POSIXct(dateTimeVector)




# make plot 4
# adjust margins
par(mar=c(4,4,5,4))

# set layout to four plots (fill rowwise)
par(mfrow = c(2,2))

# plot4:1
plot(data$DateTime, data$Global_active_power, ylab = "Global Active Power",xlab="", type="l", axes = T)

# plot4:2
plot(data$DateTime, data$Voltage, ylab = "Voltage",xlab="datetime", type="l", axes = T)

# plot4:3
plot(data$DateTime, data$Sub_metering_1, type = "l", ylab = "Energy sub metering",xlab="" )
# add the lines
lines(data$DateTime, data$Sub_metering_1,col="black")
lines(data$DateTime, data$Sub_metering_2,col="red")
lines(data$DateTime, data$Sub_metering_3,col="blue")
# add legends
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=c("black","red","blue"), cex=0.7,  bty = "n")

# plot4:4
plot(data$DateTime, data$Global_reactive_power, ylab = "Global_reactive_power",xlab="datetime", type="l", axes = T)



#write png file
png(file = "plot4.png",bg = "transparent")

# adjust margins for png
par(mar=c(5,4,4,3))


# set layout to four plots (fill rowwise)
par(mfrow = c(2,2))

# make plot 4

# plot4:1
plot(data$DateTime, data$Global_active_power, ylab = "Global Active Power",xlab="", type="l", axes = T)

# plot4:2
plot(data$DateTime, data$Voltage, ylab = "Voltage",xlab="datetime", type="l", axes = T)

# plot4:3
plot(data$DateTime, data$Sub_metering_1, type = "l", ylab = "Energy sub metering",xlab="" )
# add the lines
lines(data$DateTime, data$Sub_metering_1,col="black")
lines(data$DateTime, data$Sub_metering_2,col="red")
lines(data$DateTime, data$Sub_metering_3,col="blue")
# add legends
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=c("black","red","blue"), cex=0.95,  bty = "n")

# plot4:4
plot(data$DateTime, data$Global_reactive_power, ylab = "Global_reactive_power",xlab="datetime", type="l", axes = T)

#close dev
dev.off()

#clean up
par(mfrow = c(1,1))
rm(fname,linesToKeep,lns,data,dateTimeVector)

#done!
print("Plot written to plot4.png!")
