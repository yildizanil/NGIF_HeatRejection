# Ground heat exchange potential of Green Infrastructure
# Yildiz, A. and Stirling, R.A.
# Submitted to Geothermics
# Function to convert time data to POSIXct data with UTC time zone
utc <- function(x) {
  as.POSIXct(x, tz = "UTC")
  }
# time frame of Set I
startdate <- utc("2019-07-18 00:00:00")
enddate <- utc("2019-08-06 00:00:00")
# Importing datasets
soil_temp_link <- "https://ndownloader.figshare.com/files/28324365?private_link=17cf9f87af8a160f14c2"
meteo_link <- "https://ndownloader.figshare.com/files/28394079?private_link=31e846de1eb5f79ac815"
heat_flux_link <- "https://ndownloader.figshare.com/files/28324713?private_link=5f8ecef47b99ce475574"
soil_temp <- read.csv(soil_temp_link, header = T, stringsAsFactors = F)
meteo <- read.csv(meteo_link, stringsAsFactors = F)
heat_flux <- read.csv(heat_flux_link, stringsAsFactors = F)
# extracting data from the time frame of Set I
soil_temp_set1 <- soil_temp[which(utc(soil_temp[, 1]) > startdate - 1 &
                                    utc(soil_temp[, 1]) < enddate), ]
meteo_set1 <- meteo[which(utc(meteo[, 1]) > startdate - 1 &
                            utc(meteo[, 1]) < enddate), ]
heat_flux_set1 <- heat_flux[which(utc(heat_flux[, 1]) > startdate - 1 &
                                    utc(heat_flux[, 1]) < enddate), ]
# dates of experiments
dates <- read.csv("https://raw.githubusercontent.com/yildizanil/GeothermicsPaper/main/fieldtest.csv")
# defining the midday point as a POSIXct data for each day,
# i.e. YYYY-MM-DD 12:00:00
meteo_midday <- (utc(meteo[, 1]) + 60 * 60 * 12)
# RGB codes of NGIF colours used in the figures
green <- rgb(157 / 256, 175 / 256, 33 / 256)
blue <- rgb(32 / 256, 137 / 256, 203 / 256)
# axis tick marks and labels
axis_seq <- as.character(seq.Date(as.Date(startdate), as.Date(enddate), "week"))
axis_names <- paste0(substr(axis_seq, start = 9, stop = 10), "-",
  substr(axis_seq, start = 6, stop = 7))
axis_ticks1 <- utc(axis_seq)
axis_ticks2 <- seq(startdate, enddate, 60 * 60 * 24)
# assigning indices for different datasets
index_pch <- c(NA, 18, NA, 17, 0, 1, 15, 16)
index_lty <- c(3, 3, 1, 1, 1, 1, 1, 1)
index_col <- c(green, blue, green, blue, green, blue, green, blue)
index_name <- c("@ 100 mm", "@ 250 mm", "@ 350 mm", "@ 450 mm",
  "@ 550 mm", "@ 650 mm", "@ 750 mm", "@ 850 mm")
index_column <- c(4, 6, 7, 8, 9, 10, 11, 13)
# defining file location to export pdf
file_loc <- "Figures/"
# plotting a pdf
pdf(paste0(file_loc, "Yildiz&Stirling_2022_Fig5.pdf"),
  height = 115 / 25.4, width = 150 / 25.4)
# defining a custom layout
layout(matrix(c(1, 2, 3, 4, 5), 5, 1),
  heights = c(5, 10, 50, 40, 10), widths = c(150))
# first legend
par(mar = c(0, 2.25, 0, 0.25), mgp = c(0.1, 0.1, 0),
  family = "serif", ps = 10, cex = 1, cex.main = 1, las = 1)
plot(0, 0, xlim = c(startdate, enddate), ylim = c(15, 30),
  type = "l", axes = F, xlab = NA, ylab = NA)
legend("center", c("Mean air temperature"), pch = 10, col = 1, bty = "n")
# second legend
par(mar = c(0, 2.25, 0, 0.25), mgp = c(0.1, 0.1, 0),
  family = "serif", ps = 10, cex = 1, cex.main = 1, las = 1)
plot(0, 0, xlim = c(startdate, enddate), ylim = c(15, 30),
  type = "l", axes = F, xlab = NA, ylab = NA)
legend("center", index_name, pch = index_pch,
  lty = index_lty, col = index_col, bty = "n", ncol = 4, lwd = 2)
# first subplot
par(mar = c(0.25, 2.25, 0.25, 0.25), mgp = c(0.1, 0.1, 0),
  family = "serif", ps = 10, cex = 1, cex.main = 1, las = 1)
plot(0, 0, xlim = c(startdate, enddate), ylim = c(15, 30),
  type = "l", axes = F, xlab = NA, ylab = NA)
for (i in 1:3) {
  rect(xleft = utc(dates[i, 1]), ybottom = 15,
       xright = utc(dates[i, 2]), ytop = 30, border = NA, col = "gray90")
}
segments(x0 = seq(startdate, enddate, 60 * 60 * 24), y0 = 15,
  x1 = seq(startdate, enddate, 60 * 60 * 24), y1 = 30, col = "gray87")
segments(x0 = startdate, y0 = seq(15, 30, 2.5),
  x1 = enddate, y1 = seq(15, 30, 2.5), col = "gray87")
axis(1, tck = 0.02, at = axis_ticks2, labels = NA)
axis(1, tck = 0.04, at = axis_ticks1, labels = NA)
axis(2, tck = 0.02, at = c(15, 20, 25, 30), labels = c(15, 20, 25, 30))
box()
for (i in seq_len(index_column)) {
  points(x = utc(soil_temp_set1[seq(1, nrow(soil_temp_set1), 50), 1]),
    y = soil_temp_set1[seq(1, nrow(soil_temp_set1), 50), index_column[i]],
    col = index_col[i], pch = index_pch[i], cex = 0.8)
  lines(soil_temp_set1[, index_column[i]]~utc(soil_temp_set1[, 1]),
    lwd = 2, col = index_col[i], lty = index_lty[i])
}
points(meteo$AirTemp_Mean[1:18]~meteo_midday[1:18], col = 1, pch = 10)
par(las = 0)
mtext("Air/soil temperature [°C]", side = 2, line = 1)
for (i in 1:3) {
  text(utc(dates[i, 1]) + 60 * 60 * 36, 30, paste0("Test I-", i),
    adj = c(0.5, 1), font = 2)
  text(utc(dates[i, 2]) + 60 * 60 * 48, 30, paste0("Off"),
    adj = c(0.5, 1), font = 2)
}
text(startdate, 30, "A", adj = c(0, 1), font = 2)
# second subplot
par(mar = c(0.25, 2.25, 0.25, 0.25), mgp = c(0.1, 0.1, 0),
  family = "serif", ps = 10, cex = 1, cex.main = 1, las = 1)
plot(0, 0, xlim = c(startdate, enddate), ylim = c(-5, 35),
  type = "l", axes = F, xlab = NA, ylab = NA)
for (i in 1:3) {
  rect(xleft = as.POSIXct(dates[i, 1]), ybottom = -5,
       xright = as.POSIXct(dates[i, 2]), ytop = 35, border = NA, col = "gray90")
}
segments(x0 = seq(startdate, enddate, 60 * 60 * 24), y0 = -5,
  x1 = seq(startdate, enddate, 60 * 60 * 24), y1 = 35, col = "gray87")
segments(x0 = startdate, y0 = seq(-5, 35, 5),
  x1 = enddate, y1 = seq(-5, 35, 5), col = "gray87")
axis(1, tck = 0.02, at = axis_ticks2, labels = NA)
axis(1, tck = 0.04, at = axis_ticks1, labels = axis_names)
axis(2, tck = 0.02)
box()
lines(heat_flux_set1$HF.Bottom~utc(heat_flux_set1[, 1]), lwd = 2)
par(las = 0)
mtext(expression(paste("Heat flux @ 940 mm [W/m"^2, "]")), side = 2, line = 1)
for (i in 1:3) {
  text(utc(dates[i, 1]) + 60 * 60 * 36, 35, paste0("Test I-", i),
    adj = c(0.5, 1), font = 2)
  text(utc(dates[i, 2]) + 60 * 60 * 48, 35, paste0("Off"),
    adj = c(0.5, 1), font = 2)
}
mtext("Time [DD-MM-2019]", side = 1, line = 1)
text(startdate, 35, "B", adj = c(0, 1), font = 2)
dev.off()