file<-as.character("household_power_consumption.txt")
library(sqldf)
Data<-read.csv.sql(file,sql="select * from file",header=TRUE,sep=";")
#Adding a column with date string converted to Date Class
Data$DateM<-as.Date(Data$Date,format="%d/%m/%Y")
#Character Strings for Date Filter
sdate1 <- "02-01-2007"
sdate2 <- "02-02-2007"
#Converting Date Strings to Date Class
ndate1 <- as.Date(sdate1, "%m-%d-%Y")
ndate2 <- as.Date(sdate2, "%m-%d-%Y")
#Subsetting Data 
ReqData<-subset(Data,Data$DateM>=ndate1 & Data$DateM<=ndate2 )
#Plotting Plot 1 and Saving the plot
png("plot1.png", width = 480, height = 480)
hist(ReqData$Global_active_power,col='Red',main="Global Active Power"
     ,xlab='Global Active Power (kilowatts)',axes=FALSE)
axis(1, las=1, at=2*0:6)
axis(2, las=1, at=200*0:1200)
dev.off()
