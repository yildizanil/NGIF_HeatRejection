# Ground heat exchange potential of Green Infrastructure
# Yildiz,  A. and Stirling,  R.A.
# Submitted to Geothermics
# importing self-written functions
source("Functions.r")
# time frame presented in the manuscript
startdate <- utc("2019-07-18 00:00:00")
enddate <- utc("2019-09-12 00:00:00")
# importing datasets from the repository
source("FDM/00_main.r")
# importing model metrics
source("FDM/model_metrics.r")
# generating vectors to store model metrics
mape_data <- NA
rmse_data <- NA
r2_data <- NA
# calculating model performance metrics
for (k in 2:ncol(data_predicted)) {
  mape_data[k] <- mape(y_observed = data_observed[, k],
    y_predicted  =  data_predicted[, k])
  rmse_data[k] <- rmse(y_observed = data_observed[, k],
    y_predicted  =  data_predicted[, k], normalise  =  T)
  r2_data[k] <- r2(y_observed = data_observed[, k],
    y_predicted  =  data_predicted[, k])
}
# RGB codes of NGIF colours
green <- rgb(157 / 256, 175 / 256, 33 / 256)
blue <- rgb(32 / 256, 137 / 256, 203 / 256)
# Axis tick marks and labels
axis_seq <- as.character(seq.Date(as.Date(startdate), as.Date(enddate), "week"))
axis_names <- paste0(substr(axis_seq, start = 9, stop = 10), "-",
  substr(axis_seq, start = 6, stop = 7))
axis_ticks1 <- utc(axis_seq)
axis_ticks2 <- seq(startdate, enddate, 60 * 60 * 24)
# index of depth values to plot
index <- c(3, 6, 8, 10, 12, 14, 16, 18)
depth <- seq(50, 850, 50)
# Defining file location
file.loc <- "Figures/"
# Plotting a pdf
pdf(paste0(file.loc, "Yildiz&Stirling_2022_Fig7.pdf"),
height = 140 / 25.4, width = 190 / 25.4)
# Generating a layout
layout(matrix(c(1, 2, 3, 4, 5, 10, 1, 6, 7, 8, 9, 10),
              nrow = 6, ncol = 2, byrow = F),
        width = c(95, 95), heights = c(10, 30, 30, 30, 30, 10))
# Plotting subfigures
par(mar = c(0, 0, 0, 0), mgp = c(0.1, 0.1, 0),
  family = "serif", ps = 10, cex = 1, cex.main = 1, las = 1, pty = "m")
plot(0, 0, xlim = c(0, 0), ylim = c(10, 30),
  type = "l", axes = F, xlab = NA, ylab = NA)
legend("center", c("Measured", "Estimated"),
  lwd = 2, lty = c(3, 1), col = c(1, blue), hor = T, bty = "n")
for (i in 1:8) {
  par(mar = c(0.25, 2, 0.25, 0.5), mgp = c(0.1, 0.1, 0),
    family = "serif", ps = 10, cex = 1, cex.main = 1, las = 1)
  plot(0, 0, xlim = c(startdate, enddate), ylim = c(10, 30),
    type = "l", axes = F, xlab = NA, ylab = NA)
  add_grid(x_0 = startdate, x_n = enddate,
      y_0 = 10, y_n = 30,
      dx = 60 * 60 * 24, dy = 5)
  axis(1, tck = 0.02, at = axis_ticks2, labels = NA)
  axis(1, tck = 0.04, at = axis_ticks1, labels = NA)
  axis(2, tck = 0.02, at = c(15, 20, 25, 30), labels = c(15, 20, 25, 30))
  box()
  lines(data_predicted[, index[i]] ~ utc(data_observed$Time),
    lwd = 1, col = blue, lty = 1)
  lines(data_observed[, index[i]] ~ utc(data_observed$Time),
    lwd = 2, col = 1, lty = 3)
  text(enddate, 30,
    paste0("nRMSE = ", round(rmse_data[index[i]], 2),  "%\n",
          "MAPE = ", round(mape_data[index[i]], 2),  "%"), adj = c(1, 1))
  text(startdate, 30, paste0(LETTERS[i]), adj = c(0, 1), font = 2)
  if (i == 4 | i == 8) {
    axis(1, tck = 0.02, at = axis_ticks2, labels = NA)
    axis(1, tck = 0.04, at = axis_ticks1, labels = axis_names)
    par(las = 0)
    mtext("Time [DD-MM-2019]", side = 1, line = 1)
  }
  if (i == 2 | i == 6) {
    par(las = 0)
    mtext("Soil temperature [°C]", side = 2, line = 1, at = 10)
  }
}
dev.off()
