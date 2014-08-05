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
                   colClasses=c("myDate","character","numeric", NULL,NULL,NULL, NULL,NULL,NULL)
)

# set layout to one plot
par(mfrow = c(1,1))

# add column for DateTime:
dateTimeVector <- apply( data[,1:2] , 1, paste ,collapse = " " )
data$DateTime <- as.POSIXct(dateTimeVector)

# make plot 2
plot(data$DateTime, data$Global_active_power, ylab = "Global Active Power (kilowatts)",xlab="", type="l", axes = T)


#write png file
png(file = "plot2.png",bg = "transparent")
# adjust margins for png
par(mar=c(5,4,4,3))
# make plot 2
plot(data$DateTime, data$Global_active_power, ylab = "Global Active Power (kilowatts)",xlab="", type="l", axes = T)
#close dev
dev.off()

#clean up
rm(fname,linesToKeep,lns,data,dateTimeVector)

#done!
print("Plot written to plot2.png!")
