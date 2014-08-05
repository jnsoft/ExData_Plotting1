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

# set layout to one plot
par(mfrow = c(1,1))

# make plot 1
hist(data$Global_active_power,
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency"
     )

#write png file
png(file = "plot1.png",bg = "transparent")
# adjust margins for png
par(mar=c(4,4,3,4))
# make plot 1
hist(data$Global_active_power,
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency"
)
#close dev
dev.off()

#clean up
rm(fname,linesToKeep,lns,data)

#done!
print("Plot written to plot1.png!")
