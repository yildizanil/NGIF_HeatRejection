#-------------------------------------------------------------------------------#
# Time frame presented in the paper                          
#-------------------------------------------------------------------------------#
startdate <- as.POSIXct("2019-07-18 00:00:00",tz="UTC")
enddate <- as.POSIXct("2019-09-12 00:00:00",tz="UTC")
dates <- read.csv("https://raw.githubusercontent.com/yildizanil/GeothermicsPaper/main/fieldtest.csv")
#-------------------------------------------------------------------------------#
# RGB codes of NGIF colours                             
#-------------------------------------------------------------------------------#
red <- rgb(241, 158, 177, maxColorValue = 256)
blue <- rgb(142, 186, 229, maxColorValue = 256)
yellow <- rgb(250, 190, 80, maxColorValue = 256)

axis_seq <- as.character(seq.Date(as.Date(startdate),as.Date(enddate),"week"))
axis_names <- paste0(substr(axis_seq,start=9,stop=10),"-",substr(axis_seq,start=6,stop=7))
axis_ticks1 <- as.POSIXct(axis_seq,"UTC")
axis_ticks2 <- seq(startdate,enddate,60*60*24)

time <- seq(startdate,enddate,60*15)
timeline <- rep(0,5377)

for(i in 1:27)
{
  timeline[which(time>dates[i,1] & time < dates[i,2])] <- dates$Power[i]   
}

jpeg("icegt2020/figures/fig_timeline1.jpeg",
     width=200, height=140, res=1000, units="mm")
par(mar = c(3.25, 3.25, 0.25, 0.25), mgp = c(0.1, 0.1, 0),
    family = "sans", ps = 14, cex = 1, cex.main = 1, las = 1)
plot(0, 0, xlim = c(startdate, enddate), ylim = c(0, 50),
     axes = F, xlab = NA, ylab = NA, pch = "")
segments(x0 = seq(startdate, enddate, 60 * 60 * 24), y0 = 0,
         x1 = seq(startdate, enddate, 60 * 60 * 24), y1 = 50, col = "gray87")
segments(x0 = startdate, y0 = seq(0, 50, 2),
         x1 = enddate, y1 = seq(0, 50, 2), col = "gray87")
axis(1, tck = 0.02, at = axis_ticks2, labels = NA)
axis(1, tck = 0.04, at = axis_ticks1, labels = axis_names)
axis(2, tck = 0.02)
box()
lines(timeline[1:2000]~time[1:2000], lwd = 2, col = blue)
lines(timeline[2000:5377]~time[2000:5377], lwd = 2, col = 8)
par(las = 0)
mtext("Time [DD-MM-2019]", side = 1, line = 2)
mtext("Power [W]", side = 2, line = 2)
dev.off()


jpeg("icegt2020/figures/fig_timeline2.jpeg",
    width=200, height=140, res=1000, units="mm")
par(mar = c(3.25, 3.25, 0.25, 0.25), mgp = c(0.1, 0.1, 0),
    family = "sans", ps = 14, cex = 1, cex.main = 1, las = 1)
plot(0, 0, xlim = c(startdate, enddate), ylim = c(0, 50),
     axes = F, xlab = NA, ylab = NA, pch = "")
segments(x0 = seq(startdate, enddate, 60 * 60 * 24), y0 = 0,
         x1 = seq(startdate, enddate, 60 * 60 * 24), y1 = 50, col = "gray87")
segments(x0 = startdate, y0 = seq(0, 50, 2),
         x1 = enddate, y1 = seq(0, 50, 2), col = "gray87")
axis(1, tck = 0.02, at = axis_ticks2, labels = NA)
axis(1, tck = 0.04, at = axis_ticks1, labels = axis_names)
axis(2, tck = 0.02)
box()
lines(timeline[1:2000]~time[1:2000], lwd = 2, col = 8)
lines(timeline[2000:5377]~time[2000:5377], lwd = 2, col = red)
par(las = 0)
mtext("Time [DD-MM-2019]", side = 1, line = 2)
mtext("Power [W]", side = 2, line = 2)
dev.off()

jpeg("icegt2020/figures/fig_timeline3.jpeg",
     width=200, height=140, res=1000, units="mm")
par(mar = c(3.25, 3.25, 0.25, 0.25), mgp = c(0.1, 0.1, 0),
    family = "sans", ps = 14, cex = 1, cex.main = 1, las = 1)
plot(0, 0, xlim = c(startdate, enddate), ylim = c(0, 50),
     axes = F, xlab = NA, ylab = NA, pch = "")
segments(x0 = seq(startdate, enddate, 60 * 60 * 24), y0 = 0,
         x1 = seq(startdate, enddate, 60 * 60 * 24), y1 = 50, col = "gray87")
segments(x0 = startdate, y0 = seq(0, 50, 2),
         x1 = enddate, y1 = seq(0, 50, 2), col = "gray87")
axis(1, tck = 0.02, at = axis_ticks2, labels = NA)
axis(1, tck = 0.04, at = axis_ticks1, labels = axis_names)
axis(2, tck = 0.02)
box()
lines(timeline~time, lwd = 2, col = 1)
par(las = 0)
mtext("Time [DD-MM-2019]", side = 1, line = 2)
mtext("Power [W]", side = 2, line = 2)
dev.off()


