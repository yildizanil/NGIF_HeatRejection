# Yildiz, A. and Stirling, R.A.
# importing self-written functions
source("functions/import_data.r")
source("functions/utc.r")
source("functions/plotting_functions.r")
# time frame presented in the manuscript
startdate <- utc("2019-07-18 00:00:00")
enddate <- utc("2019-09-12 00:00:00")
# importing datasets from the repository
meteo <- import_data("meteo")
# RGB codes of NGIF colours used in the figures
red <- rgb(241, 158, 177, maxColorValue = 256)
blue <- rgb(142, 186, 229, maxColorValue = 256)
yellow <- rgb(250, 190, 80, maxColorValue = 256)
blue_02a <- rgb(red = 142, green = 186, blue = 229, maxColorValue = 256, alpha = 100)
red_02a <- rgb(red = 241, green = 158, blue = 177, maxColorValue = 256, alpha = 100)
# axis tick marks and locations
axis_seq <- as.character(seq.Date(as.Date(startdate), as.Date(enddate), "week"))
axis_names <- paste0(substr(axis_seq, start = 9, stop = 10), "-",
substr(axis_seq, start = 6, stop = 7))
axis_ticks1 <- utc(axis_seq)
axis_ticks2 <- seq(startdate, enddate, 60 * 60 * 24)
# defining file location to export pdf
file_loc <- "icegt2020/figures/"
# plotting a pdf file
jpeg(paste0(file_loc, "fig_meteo.jpeg"),
        height = 140, width = 300, res = 1000, units = "mm")
# creating a custom layout
layout(matrix(c(1, 2, 3, 4), nrow = 4, ncol = 1), heights = c(15, 45, 45, 5))
# legend
plot_white_space(margin = c(0, 0, 0, 0))
par(family = "sans", ps = 14)
legend("center", c("Rainfall", "Air temperature", "Max. - min. air temperature",
                  "Relative Humidity", "Max. - min. relative humidity",
                  "Net radiation"),
       bty = "n", ncol = 2,
       pch = c(15, NA, 15, NA, 15, NA), lwd = c(NA, 2, NA, 2, NA, 2),
       lty = c(NA, 1, NA, 2, NA, 3),
       col = c(8, 2, red_02a, blue, blue_02a, 1),
       adj = c(0, 0.5), xjust = 0.5)
# first subplot
par(mar = c(1, 3.25, 0.25, 3.25), mgp = c(0.1, 0.1, 0),
        family = "sans", ps = 14, cex = 1, cex.main = 1, las = 1)
plot(0, 0, type = "l", lwd = 3, ylim = c(0, 50), xlim = c(startdate, enddate),
        axes = F, xlab = NA, ylab = NA, pch = "")
add_grid(x_0 = startdate, x_n = enddate,
        y_0 = 0, y_n = 50,
        dx = 60 * 60 * 24, dy = 10)
axis(1, tck = 0.02, at = axis_ticks2, labels = NA)
axis(1, tck = 0.04, at = axis_ticks1, labels = axis_names)
axis(2, tck = 0.02)
for (i in seq_len(nrow(meteo))) {
  rect(xleft = utc(meteo$Time[i]), ybottom = 0,
       xright = utc(meteo$Time[i + 1]), ytop = meteo$Rain[i],
       border = T, col = 8)
}
par(new = T)
plot(0, 0, type = "l", lwd = 3, ylim = c(0, 30), xlim = c(startdate, enddate),
        axes = F, xlab = NA, ylab = NA, pch = "")
axis(4, tck = 0.02, at = seq(0, 30, 6), labels = seq(0, 30, 6))
polygon(x = c(utc(meteo$Time), rev(utc(meteo$Time))),
        y = c(meteo$AirTemp_Max, rev(meteo$AirTemp_Min)),
        border = NA, col = red_02a)
lines(meteo$AirTemp_Mean~utc(meteo$Time), col = red, lwd = 2)
par(las = 0)
box()
mtext("Daily rainfall [mm]", side = 2, line = 2.25)
mtext("Air temperature [�C]", side = 4, line = 2.25)
# second subplot
par(mar = c(1, 3.25, 0.25, 3.25), mgp = c(0.1, 0.1, 0),
        family = "sans", ps = 14, cex = 1, cex.main = 1, las = 1)
plot(0, 0, type = "l", lwd = 3, ylim = c(0, 100), xlim = c(startdate, enddate),
        axes = F, xlab = NA, ylab = NA, pch = "")
add_grid(x_0 = startdate, x_n = enddate,
        y_0 = 0, y_n = 100,
        dx = 60 * 60 * 24, dy = 20)
axis(1, tck = 0.02, at = axis_ticks2, labels = NA)
axis(1, tck = 0.04, at = axis_ticks1, labels = axis_names)
axis(2, tck = 0.02)
polygon(x = c(utc(meteo$Time), rev(utc(meteo$Time))),
        y = c(meteo$Humid_Max, rev(meteo$Humid_Min)),
        border = NA, col = blue_02a)
lines(meteo$Humid_Mean~utc(meteo$Time), col = blue, lwd = 2, lty = 2)
par(new = T)
plot(0, 0, type = "l", lwd = 3, ylim = c(-100, 400),
        xlim = c(startdate, enddate),
        axes = F, xlab = NA, ylab = NA, pch = "")
axis(4, tck = 0.02, at = seq(-100, 400, 100))
lines(meteo$NetRad~utc(meteo$Time), col = 1, lwd = 2, lty = 3)
par(las = 0)
mtext("Time [DD-MM-2019]", side = 1, line = 1)
mtext("Relative humidity [%]", side = 2, line = 2.25)
mtext(expression(paste("Net radiation [W/m"^2, "]")), side = 4, line = 2.25)
box()


dev.off()
# end