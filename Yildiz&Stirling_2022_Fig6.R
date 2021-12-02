# Ground heat exchange potential of Green Infrastructure
# Yildiz, A. and Stirling, R.A.
# Submitted to Geothermics
# Function to convert time data to POSIXct data with UTC time zone
utc <- function(x){as.POSIXct(x,"UTC")}
# time frame of Set II
startdate <- utc("2019-08-08 00:00:00")
enddate <- utc("2019-09-12 00:00:00")
# importing datasets                                 
soil_temp_link <- "https://ndownloader.figshare.com/files/28324365?private_link=17cf9f87af8a160f14c2"
meteo_link <- "https://ndownloader.figshare.com/files/28394079?private_link=31e846de1eb5f79ac815"
heat_flux_link <- "https://ndownloader.figshare.com/files/28324713?private_link=5f8ecef47b99ce475574"
soil_temp <- read.csv(soil_temp_link,header = T,stringsAsFactors = F)
meteo <- read.csv(meteo_link,stringsAsFactors=F)
heat_flux <- read.csv(heat_flux_link,stringsAsFactors=F)
# extracting data from the time frame of Set II
soil_temp_set2 <- soil_temp[which(as.POSIXct(soil_temp[,1],"UTC") > startdate-1 &
                                    as.POSIXct(soil_temp[,1],"UTC") < enddate),]
meteo_set2 <- meteo[which(as.POSIXct(meteo[,1],"UTC") > startdate-1 &
                            as.POSIXct(meteo[,1],"UTC") < enddate),]
heat_flux_set2 <- heat_flux[which(as.POSIXct(heat_flux[,1],"UTC") > startdate-1 &
                                    as.POSIXct(heat_flux[,1],"UTC") < enddate),]
# dates of experiments                                
dates <- read.csv("https://raw.githubusercontent.com/yildizanil/GeothermicsPaper/main/fieldtest.csv")
# defining the midday point as a POSIXct data for each day, i.e. YYYY-MM-DD 12:00:00
meteo.midday <- (as.POSIXct(meteo[,1],"UTC")+60*60*12)
# RGB codes of NGIF colours used in the figures
green <- rgb(157/256,175/256,33/256)
blue <- rgb(32/256,137/256,203/256)
# axis tick marks and labels                            
axis_seq <- as.character(seq.Date(as.Date(startdate),as.Date(enddate),"week"))
axis_names <- paste0(substr(axis_seq,start=9,stop=10),"-",substr(axis_seq,start=6,stop=7))
axis_ticks1 <- as.POSIXct(axis_seq,"UTC")
axis_ticks2 <- seq(startdate,enddate,60*60*24)
# defining 15-minute time steps
time <- seq(startdate,enddate,60*15)
# calculation the difference in soil temperature between the end and beginning of each test
diff <- soil_temp_set2[which(time%in%utc(dates[4:27,2])),4:14]-soil_temp_set2[which(time%in%utc(dates[4:27,1]))+1,4:14]
# defining file location to export pdf
file_loc <- "C:/Users/Anil/Desktop/Geothermics_Final/"
# plotting a pdf file
pdf(paste0(file_loc,"FIG_SetII_v2.pdf"),height=105/25.4,width=150/25.4)

layout(matrix(c(1,2,3),nrow=3,ncol=1,byrow=T),widths=c(150),heights=c(10,50,50))
par(mar=c(0,0,0,0),mgp=c(0.1,0.1,0),family="serif",ps=10,cex=1,cex.main=1,las=1,pty="m")
plot(0,0,xlim=c(startdate,enddate),ylim=c(12,22),type="l",axes=F,xlab=NA,ylab=NA)
legend("center",c("Soil temperature","Heat flux"),lty=1,col=c(blue,green),hor=T,bty="n",lwd=2)
# first subplot
par(mar=c(2,2.25,0.25,2.25),mgp=c(0.1,0.1,0),family="serif",ps=10,cex=1,cex.main=1,las=1)
plot(0,0,xlim=c(startdate,enddate),ylim=c(12,22),type="l",axes=F,xlab=NA,ylab=NA)
segments(x0=seq(startdate,enddate,60*60*24),y0=12,x1=seq(startdate,enddate,60*60*24),y1=22,col="gray87")
segments(x0=startdate,y0=seq(12,22,1),x1=enddate,y1=seq(12,22,1),col="gray87")
axis(1,tck=0.02,at=axis_ticks2,labels=NA)
axis(1,tck=0.04,at=axis_ticks1,labels=axis_names)
axis(2,tck=0.02)
box()
par(las=0)
mtext("Soil temperature @ 850 mm [?C]",side=2,line=1.25)
mtext("Time [DD-MM-2019]",side=1,line=1)

lines(soil_temp_set2[,13]~utc(soil_temp_set2$Time),lwd=2,col=blue)
par(new=T,las=1)
plot(0,0,xlim=c(startdate,enddate),ylim=c(0,30),type="l",axes=F,xlab=NA,ylab=NA)
axis(4,tck=0.02)
par(las=0)
mtext(expression(paste("Heat flux @ 940 mm [W/m"^2,"]")),side=4,line=1.25)
lines(heat_flux_set2$HF.Bottom~as.POSIXct(heat_flux_set2$Time,"UTC"),lwd=2,lty=1,col=green)
text(startdate,30,"A",font=2,adj=c(0,1))

par(mar=c(2,2.25,0.25,2.25),mgp=c(0.1,0.1,0),family="serif",ps=10,cex=1,cex.main=1,las=1)
plot(0,0,xlim=c(-0.5,2.5),ylim=c(950,0),type="l",axes=F,xlab=NA,ylab=NA)
segments(x0=seq(-0.5,2.5,0.25),y0=0,x1=seq(-0.5,2.5,0.25),y1=950,col="gray87")
segments(x0=-0.5,y0=seq(0,950,50),x1=2.5,y1=seq(0,950,50),col="gray87")
axis(1,tck=0.02)
axis(2,tck=0.02,at=seq(50,950,100))
arrows(x0=colMeans(diff),y0=as.numeric(substr(colnames(diff),2,4)),
       x1=colMeans(diff)+sapply(diff,sd),y1=as.numeric(substr(colnames(diff),2,4)),col=1,length = 0.05,angle=90)
arrows(x0=colMeans(diff),y0=as.numeric(substr(colnames(diff),2,4)),
       x1=colMeans(diff)-sapply(diff,sd),y1=as.numeric(substr(colnames(diff),2,4)),col=1,length = 0.05,angle=90)
points(as.numeric(substr(colnames(diff),2,4))~colMeans(diff),pch=21,bg=blue)
box()
par(las=0)
mtext("Temperature difference [?C]",side=1,line=1)
mtext("Depth[mm]",side=2,line=1.25)
text(-0.5,0,"B",font=2,adj=c(0,1))

dev.off()

