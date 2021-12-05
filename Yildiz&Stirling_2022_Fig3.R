# Ground heat exchange potential of Green Infrastructure
# Yildiz, A. and Stirling, R.A.
# Submitted to Geothermics
# Function to convert time data to POSIXct data with UTC time zone
utc <- function(x) {
        as.POSIXct(x, tz = "UTC")
        }
# time frame presented in the manuscript
startdate <- utc("2019-07-18 00:00:00")
enddate <- utc("2019-09-12 00:00:00")
# importing datasets from the repository
meteo_link <- "https://ndownloader.figshare.com/files/28394079?private_link=31e846de1eb5f79ac815" # nolint
meteo <- read.csv(meteo_link, stringsAsFactors = F)
# RGB codes of NGIF colours used in the figures
green <- rgb(157/256, 175/256, 33/256) # nolint
blue <- rgb(32/256, 137/256, 203/256) # nolint
# axis tick marks and locations
axis_seq <- as.character(seq.Date(as.Date(startdate), as.Date(enddate), "week"))
axis_names <- paste0(substr(axis_seq, start = 9, stop = 10), "-",
substr(axis_seq, start = 6, stop = 7))
axis_ticks1 <- utc(axis_seq)
axis_ticks2 <- seq(startdate, enddate, 60*60*24) # nolint
# defining file location to export pdf
file_loc <- "Figures/"
# plotting a pdf file
pdf(paste0(file_loc, "Yildiz&Stirling_2022_Fig3.pdf"), height = 110/25.4, width = 150/25.4) # nolint
# creating a custom layout
layout(matrix(c(1, 2, 3, 4), nrow = 4, ncol = 1), heights = c(15, 45, 45, 5))
# legend
par(mar = c(0, 0, 0, 0), mgp = c(0.1, 0.1, 0), family = "serif", ps = 10, cex = 1, cex.main = 1, las = 1) # nolint
plot(0, 0, xlab = NA, ylab = NA, axes = F, pch = "")
legend("center", c("Rainfall", "Air temperature", "Max. - min. air temperature",
                  "Relative Humidity", "Max. - min. relative humidity", "Net radiation"),
       bty = "n", ncol = 2,
       pch = c(15, NA, 15, NA, 15, NA), lwd = c(NA, 2, NA, 2, NA, 2),
       lty = c(NA, 1, NA, 2, NA, 3), col = c(8, 2, rgb(1, 0, 0, 0.2), blue, rgb(32/256, 137/256, 203/256, 0.2), 1), adj = c(0, 0.5), xjust = 0.5)
# first subplot
par(mar = c(1, 2.25, 0.25, 2.25), mgp = c(0.1, 0.1, 0), family = "serif", ps = 10, cex = 1, cex.main = 1, las = 1)
plot(0, 0, type = "l", lwd = 3, ylim = c(0, 50), xlim = c(startdate, enddate), axes = F, xlab = NA, ylab = NA, pch = "")
segments(x0 = seq(startdate, enddate, 60*60*24), y0 = 0,
         x1 = seq(startdate, enddate, 60*60*24), y1 = 50, col = "gray87", lty = 1)
segments(x0 = startdate, y0 = seq(0, 50, 10),
         x1 = enddate, y1 = seq(0, 50, 10), col = "gray87", lty = 1)
axis(1, tck = 0.02, at = axis_ticks2, labels = NA)
axis(1, tck = 0.04, at = axis_ticks1, labels = axis_names)
axis(2, tck = 0.02)
for(i in seq_len(nrow(meteo)))
{
  rect(xleft = utc(meteo$Time[i]), ybottom = 0,
       xright = utc(meteo$Time[i+1]), ytop = meteo$Rain[i], border = T, col = 8)  
}
text(startdate, 50, "A", adj = c(0, 1), font = 2)
par(new = T)
plot(0, 0, type = "l", lwd = 3, ylim = c(0, 30), xlim = c(startdate, enddate), axes = F, xlab = NA, ylab = NA, pch = "")
axis(4, tck = 0.02, at = seq(0, 30, 6), labels = seq(0, 30, 6))
polygon(x = c(utc(meteo$Time), rev(utc(meteo$Time))),
        y = c(meteo$AirTemp_Max, rev(meteo$AirTemp_Min)),
        border = NA, col = rgb(1, 0, 0, 0.2))
lines(meteo$AirTemp_Mean~utc(meteo$Time), col = 2, lwd = 2)
par(las = 0)
box()
mtext("Daily rainfall [mm]", side = 2, line = 1.25)
mtext("Air temperature [°C]",side = 4, line = 1.25)
# second subplot
par(mar = c(1, 2.25, 0.25, 2.25), mgp = c(0.1, 0.1, 0), family = "serif", ps = 10, cex = 1, cex.main = 1, las = 1)
plot(0, 0, type = "l", lwd = 3, ylim = c(0, 100), xlim = c(startdate, enddate), axes = F, xlab = NA, ylab = NA, pch = "")
segments(x0 = seq(startdate, enddate, 60*60*24), y0 = 0,
         x1 = seq(startdate, enddate, 60*60*24), y1 = 100, col = "gray87", lty = 1)
segments(x0 = startdate, y0 = seq(0, 100, 20),
         x1 = enddate, y1 = seq(0, 100, 20), col = "gray87", lty = 1)
axis(1, tck = 0.02, at = axis_ticks2, labels = NA)
axis(1, tck = 0.04, at = axis_ticks1, labels = axis_names)
axis(2, tck = 0.02)
polygon(x = c(utc(meteo$Time), rev(utc(meteo$Time))),
        y = c(meteo$Humid_Max, rev(meteo$Humid_Min)),
        border = NA, col = rgb(32/256, 137/256, 203/256, 0.2))
lines(meteo$Humid_Mean~utc(meteo$Time), col = blue, lwd = 2, lty = 2)
text(startdate, 100, "B", adj = c(0, 1), font = 2)
par(new = T)
plot(0, 0, type = "l", lwd = 3, ylim = c(-100, 400), xlim = c(startdate, enddate), axes = F, xlab = NA, ylab = NA, pch = "")
axis(4, tck = 0.02, at = seq(-100, 400, 100))
lines(meteo$NetRad~utc(meteo$Time), col = 1, lwd = 2, lty = 3)
par(las = 0)
mtext("Time [DD-MM-2019]", side = 1, line = 1)
mtext("Relative humidity [%]", side = 2, line = 1.25)
mtext(expression(paste("Net radiation [W/m"^2, "]")), side = 4, line = 1.25)
box()

dev.off()
# end