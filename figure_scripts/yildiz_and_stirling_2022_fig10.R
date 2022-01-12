# Ground heat exchange potential of Green Infrastructure
# Yildiz,  A. and Stirling,  R.A.
# Submitted to Geothermics
# importing self-written functions
source("functions/import_data.r")
source("functions/utc.r")
source("functions/plotting_functions.r")
source("functions/interpolate_soil_temperature.r")
# performing model calculation
source("finite_difference_modelling/00_main.r")
depth <- seq(50, 850, 50)
time <- seq(startdate, enddate, 60 * 60 * 0.25)
temp <- seq(10, 30, 1)
axis_seq <- as.character(seq.Date(as.Date(startdate), as.Date(enddate), "week"))
axis_names <- paste0(substr(axis_seq, start = 9, stop = 10), "-",
  substr(axis_seq, start = 6, stop = 7))
axis_ticks1 <- as.POSIXct(axis_seq, "UTC")
axis_ticks2 <- seq(startdate, enddate, 60 * 60 * 24)
# plotting Figure 9
jpeg(filename = "figures/yildiz_and_stirling_2022_fig10.jpeg",
  width = 150, height = 110, units = "mm", res = 600)
layout(matrix(c(1, 2), nrow = 1, ncol = 2), widths = c(10, 2))
par(mar = c(2, 2.25, 0.25, 0.25), mgp = c(0.1, 0.1, 0),
  family = "serif", ps = 10, cex = 1, cex.main = 1, las = 1)
plot(0, 0, xlim = c(startdate, enddate), ylim = c(950, 0),
  type = "l", axes = F, xlab = NA, ylab = NA)
segments(x0 = seq(startdate, enddate, 60 * 60 * 24), y0 = 0,
  x1 = seq(startdate, enddate, 60 * 60 * 24), y1 = 950,
  col = rgb(0, 0, 0, 0.1))
axis(1, tck = 0.02, labels = NA, at = axis_ticks2)
axis(1, tck = 0.03, labels = axis_names, at = axis_ticks1)
axis(2, tck = 0.02, at = depth, labels = depth)
box()
for (j in seq_len(length(depth))) {
  for (i in seq_len(nrow(data_observed))) {
    rect(xleft = as.POSIXct(data_predicted[i, 1], "UTC"),
    ybottom = depth[j] - 25,
    xright = as.POSIXct(data_predicted[i + 1, 1], "UTC"),
    ytop = depth[j] + 25,
    col = viridis::plasma(20)[findInterval(data_predicted[i, j + 1], temp)],
    border = NA)
  }
}
rect(xleft = startdate, ybottom = 950, xright = enddate, ytop = 0, border  =  T)
par(las = 0)
mtext("Depth [mm]", side = 2, line = 1.25)
mtext("Time [DD-MM-2019]", side = 1, line = 1)
# plotting white space with 0 margin
plot_white_space(margin = c(0, 0, 0, 0))
# plotting legend
for (i in 1:20) {
  rect(xleft = 0, ybottom = (i - 1) * (0.9 / 20),
    xright = 0.5, ytop = i * (0.9 / 20),
    col = viridis::plasma(20)[i], border = NA)
  text(0.55, (i - 1) * (0.9 / 20), temp[i], adj = c(0, 0.5))
}
text(0.55, 0.9, 30, adj = c(0, 0.5))
text(0, 1, "Temperature \n °C", adj = c(0, 1))
dev.off()