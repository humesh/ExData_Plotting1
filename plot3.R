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
#Transforming Data into required format
ReqData$DateTime<-paste(ReqData$Date, ReqData$Time)
ReqData$DateTimeM<-strptime(ReqData$DateTime,"%d/%m/%Y %H:%M:%S")
ReqData$Weekdays<-weekdays(ReqData$DateTimeM)
###########################################
#Plotting Plot 3 and Saving the plot
png("plot3.png", width = 480, height = 480)
plot(ReqData$DateTimeM,ReqData$Sub_metering_1,type="n",ylab="Energy sub metering",xlab="",
     cex.lab=1.2)
lines(ReqData$DateTimeM,ReqData$Sub_metering_1)
lines(ReqData$DateTimeM,ReqData$Sub_metering_2,col="Red")
lines(ReqData$DateTimeM,ReqData$Sub_metering_3,col="Blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1,lwd=1,col=c("black","red","blue"),ncol=1,cex=0.9, 
       bty="1",  
       inset =c(0,0),
       text.col=c("black"))
dev.off()