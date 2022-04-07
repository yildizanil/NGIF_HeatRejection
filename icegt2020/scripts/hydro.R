# Ground heat exchange potential of yellow Infrastructure
# Yildiz, A. and Stirling, R.A.
# Submitted to Geothermics
# importing self-written functions
source("functions/import_data.r")
source("functions/utc.r")
source("functions/plotting_functions.r")
# time frame presented in the manuscript
startdate <- utc("2019-07-18 00:00:00")
enddate <- utc("2019-09-12 00:00:00")
# importing datasets from the repository
vwc <- import_data("vwc")
water_flux <- import_data("water_flux")
thermal_cond <- import_data("thermal_conductivity")
# RGB codes of NGIF colours used in the figures
red <- rgb(241, 158, 177, maxColorValue = 256)
blue <- rgb(142, 186, 229, maxColorValue = 256)
yellow <- rgb(250, 190, 80, maxColorValue = 256)
# axis tick marks and locations
axis_seq <- as.character(seq.Date(as.Date(startdate), as.Date(enddate), "week"))
axis_names <- paste0(substr(axis_seq, start = 9, stop = 10), "-",
  substr(axis_seq, start = 6, stop = 7))
axis_ticks1 <- utc(axis_seq)
axis_ticks2 <- seq(startdate, enddate, 60 * 60 * 24)
depth_to_plot <- c(250, 350, 550, 750)
# defining file location to export pdf
file_loc <- "icegt2020/figures/"
# Plotting a pdf
jpeg(paste0(file_loc, "fig_hydro.jpeg"),
  height = 140, width = 250, units = "mm", res = 1000)
# Creating a custom layout
layout(
  matrix(c(1, 2, 2, rep(3, 5),
          c(4, 5, 6, 7, 8, 9, 10, 11), 12, 13, 13, rep(14, 5)),
        nrow = 8, ncol = 3),
  heights = c(5, 30, 5, 20, 20, 20, 20, 10),
  widths = c(5, 140, 5))
# Axis labels in empty spaces
# Plotting white space with 0 margin
plot_white_space(margin = c(0, 0, 0, 0))
par(family = "sans", ps = 14)
# Plotting white space with 0 margin
plot_white_space(margin = c(0, 0, 0, 0))
par(family = "sans", ps = 14)
par(las = 0)
mtext("Water flux [mm]", side = 2, line = -1)
# Plotting white space with 0 margin
plot_white_space(margin = c(0, 0, 0, 0))
par(family = "sans", ps = 14)
par(las = 0)
mtext("Volumetric water content [%]", side = 2, line = -1)
# First legend
# Plotting white space with 1.25 margin on the left side
plot_white_space(margin = c(0, 1.25, 0, 0))
par(family = "sans", ps = 14)
legend("center", c("Rainfall", "Potential evapotranspiration"),
  col = c(1), pt.bg = c(8, yellow), ncol = 2,
  bty = "n", adj = c(0, 0.5), pch = c(22, 22))
# Rainfall & evapotranspiration plot
par(mar = c(0.25, 1.25, 0.25, 1.25), mgp = c(0.1, 0.1, 0),
  family = "sans", ps = 14, cex = 1, cex.main = 1, las = 1)
plot(0, 0, type = "l", lwd = 3,
  ylim = c(-10, 40), xlim = c(startdate, enddate),
  axes = F, xlab = NA, ylab = NA, pch = "")
add_grid(x_0 = startdate, x_n = enddate,
        y_0 = -10, y_n = 40,
        dx = 60 * 60 * 24, dy = 5)
axis(1, tck = 0.02, at = axis_ticks2, labels = NA)
axis(1, tck = 0.04, at = axis_ticks1, labels = NA)
axis(2, tck = 0.02)
box()
for (i in seq_len(nrow(water_flux))) {
  rect(xleft = utc(water_flux$Time[i]), ybottom = 0,
       xright = utc(water_flux$Time[i + 1]), ytop = water_flux$Rainfall[i],
       border = T, col = 8)
  rect(xleft = utc(water_flux$Time[i]), ybottom = 0,
       xright = utc(water_flux$Time[i + 1]), ytop = -1 * water_flux$PET[i],
       border = T, col = yellow)
}
par(las = 0)
# Second legend
# Plotting white space
plot_white_space(margin = c(0, 1.25, 0, 0))
par(family = "sans", ps = 14)
legend("center", c("Volumetric water content", "Thermal conductivity"),
  col = c(blue, 1), ncol = 2, bty = "n",
  adj = c(0, 0.5), lwd = 2, lty = c(1, 3))
# Indexing the depths to plot the water content & thermal conductivity
index <- c(3, 4, 6, 8)
# Subplots of water content & thermal conductivity
for (i in 1:4) {
  par(mar = c(0.25, 1.25, 0.25, 1.25), mgp = c(0.1, 0.1, 0),
    family = "sans", ps = 14, cex = 1, cex.main = 1, las = 1)
  plot(0, 0, xlim = c(startdate, enddate), ylim = c(0, 30),
    type = "l", axes = F, xlab = NA, ylab = NA)
  add_grid(x_0 = startdate, x_n = enddate,
        y_0 = 0, y_n = 30,
        dx = 60 * 60 * 24, dy = 5)
  axis(1, tck = 0.02, at = axis_ticks2, labels = NA)
  axis(1, tck = 0.04, at = axis_ticks1, labels = NA)
  axis(2, tck = 0.02, at = c(0, 10, 20, 30), labels = c(0, 10, 20, 30))
  box()
  lines(vwc[, index[i]]~utc(vwc$Time), lwd = 2, col = blue)
  text(startdate, 30, paste0("@",depth_to_plot[i]," mm"), adj = c(0, 1), font = 1)
  par(new = T)
  plot(1, 1, xlim = c(startdate, enddate), ylim = c(0.4, 1.6),
    type = "l", axes = F, xlab = NA, ylab = NA)
  axis(4, tck = 0.02, at = seq(0.4, 1.6, 0.4))
  lines(thermal_cond[, 6 - i] ~ utc(thermal_cond$Time),
    lwd = 3, col = 1, lty = 3)
  if (i == 4) {
    mtext("Time [DD-MM-2019]", side = 1, line = 1)
    axis(1, tck = 0.04, at = axis_ticks1, labels = axis_names)
  }
}
# Empty spaces and axis labels
# Plotting white space with 0 margin
plot_white_space(margin = c(0, 0, 0, 0))
par(family = "sans", ps = 14)
# Plotting white space with 0 margin
plot_white_space(margin = c(0, 0, 0, 0))
par(family = "sans", ps = 14)
# Plotting white space with 0 margin
plot_white_space(margin = c(0, 0, 0, 0))
par(family = "sans", ps = 14)
par(las = 0)
# Plotting white space with 0 margin
plot_white_space(margin = c(0, 0, 0, 0))
par(family = "sans", ps = 14)
par(las = 0)
mtext("Thermal conductivity [W/mK]", side = 2, line = -1.25)
dev.off()
# end
par(family = "sans", ps = 14)
