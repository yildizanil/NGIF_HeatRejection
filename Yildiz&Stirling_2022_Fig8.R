# Ground heat exchange potential of Green Infrastructure
# Yildiz,  A. and Stirling,  R.A.
# Submitted to Geothermics
numerical_experiment <- function(n) {
  # Function to convert time data to POSIXct data with UTC time zone
  utc <- function(x) {
    as.POSIXct(x, tz = "UTC")
    }
# defining volumetric heat capacity and thermal diffusivity
# of sand and topsoil as a function of volumetric water content
  c_sand <- function(vwc) {
    (296.4 + ((52.7 + 8.32 * (vwc - 5.27)) / (1 + exp(-3.24 * (vwc - 5.27)))))
    }
  a_sand <- function(vwc) {
    ((0.64 / (1 + exp(-1.72 * (vwc - 6.01)))) + 0.25)
    }
  a_topsoil <- function(vwc) {
    ((0.25 / (1 + exp(-0.78 * (vwc - 11.3)))) + 0.23)
    }
  # importing datasets from the repository
  soil_temp_link <- "https://ndownloader.figshare.com/files/28324365?private_link=17cf9f87af8a160f14c2"
  heat_flux_link <- "https://ndownloader.figshare.com/files/28324713?private_link=5f8ecef47b99ce475574"
  vwc_link <- "https://figshare.com/ndownloader/files/29095197?private_link=0c9aab5b3ab9471b4252"
  soil_temp <- read.csv(soil_temp_link, stringsAsFactors = F)
  heat_flux <- read.csv(heat_flux_link, stringsAsFactors = F)
  vwc_measured <- read.csv(vwc_link, stringsAsFactors = F)
  # creating a dataset for observations
  depth <- sprintf("%03d", seq(50, 850, 50))
  data_observed <- data.frame(matrix(NA, nrow = nrow(soil_temp),
    ncol = length(depth) + 1), row.names  =  NULL)
  colnames(data_observed) <- c("Time", paste0("Z", depth))
  # defining column numbers for measurement and interpolation points
  index_to_fill <- which(colnames(data_observed) %in% colnames(soil_temp))
  index_to_take <- which(colnames(soil_temp) %in% colnames(data_observed))
  data_observed[index_to_fill] <- soil_temp[index_to_take]
  # performing interpolation for missing points - soil temperature
  data_observed$Z050 <- round(soil_temp$Z040 + ((50 - 40) / (70 - 40)) *
    (soil_temp$Z070 - soil_temp$Z040), 2)
  data_observed$Z200 <- round(data_observed$Z150 + ((200 - 150) / (250 - 150)) *
    (soil_temp$Z250 - soil_temp$Z150), 2)
  data_observed$Z300 <- round(data_observed$Z250 + ((300 - 250) / (350 - 250)) *
    (soil_temp$Z350 - soil_temp$Z250), 2)
  data_observed$Z400 <- round(data_observed$Z350 + ((400 - 350) / (450 - 350)) *
    (soil_temp$Z450 - soil_temp$Z350), 2)
  data_observed$Z500 <- round(data_observed$Z450 + ((500 - 450) / (550 - 450)) *
    (soil_temp$Z550 - soil_temp$Z450), 2)
  data_observed$Z600 <- round(data_observed$Z550 + ((600 - 550) / (650 - 550)) *
    (soil_temp$Z650 - soil_temp$Z550), 2)
  data_observed$Z700 <- round(data_observed$Z650 + ((700 - 650) / (750 - 650)) *
    (soil_temp$Z750 - soil_temp$Z650), 2)
  # forming a dataset to store volumetric water content observations
  vwc <- data.frame(matrix(NA, nrow = nrow(vwc_measured),
    ncol = length(depth) + 1), row.names  =  NULL)
  colnames(vwc) <- c("Time", paste0("Z", depth))
  # defining column numbers for measurement and interpolation points
  index_to_fill_vwc <- which(colnames(vwc) %in% colnames(vwc_measured))
  index_to_take_vwc <- which(colnames(vwc_measured) %in% colnames(vwc))
  vwc[index_to_fill_vwc] <- vwc_measured[index_to_take_vwc]
  # performing interpolation for missing points
  # or assigning values of closest measurements for extrapolation
  vwc$Z050 <- vwc$Z100
  vwc$Z150 <- round(vwc$Z100 + ((150 - 100) / (250 - 100)) *
    (vwc$Z250 - vwc$Z100), 2)
  vwc$Z200 <- round(vwc$Z100 + ((200 - 100) / (250 - 100)) *
    (vwc$Z250 - vwc$Z100), 2)
  vwc$Z300 <- round(vwc$Z250 + ((300 - 250) / (350 - 250)) *
    (vwc$Z350 - vwc$Z250), 2)
  vwc$Z400 <- round(vwc$Z350 + ((400 - 350) / (450 - 350)) *
    (vwc$Z450 - vwc$Z350), 2)
  vwc$Z500 <- round(vwc$Z450 + ((500 - 450) / (550 - 450)) *
    (vwc$Z550 - vwc$Z450), 2)
  vwc$Z600 <- round(vwc$Z550 + ((600 - 550) / (650 - 550)) *
    (vwc$Z650 - vwc$Z550), 2)
  vwc$Z700 <- round(vwc$Z650 + ((700 - 650) / (750 - 650)) *
    (vwc$Z750 - vwc$Z650), 2)
  vwc$Z800 <- vwc$Z750
  vwc$Z850 <- vwc$Z750
  # numerical experiment
  vwc[, 2:18] <- vwc[, 2:18] * n
  # forming a dataset to store thermal diffusivity
  alpha <- as.data.frame(matrix(NA, nrow = nrow(vwc), ncol = ncol(vwc)))
  colnames(alpha) <- colnames(vwc)
  alpha[, 1] <- vwc$Time
  alpha[, 2:3] <- a_topsoil(vwc[, 2:3])
  alpha[, 5:18] <- a_sand(vwc[, 5:18])
  alpha[, 4] <- rowMeans(cbind(a_topsoil(vwc[, 3]), a_sand(vwc[, 5])))
  # calculating heat flux at the lower boundary
  t875 <- rowMeans(soil_temp[, c(13, 14)], na.rm = T)
  t900 <- soil_temp$Z900
  q850 <- data.frame(Time = vwc_measured[seq_len(nrow(vwc_measured) - 1), 1],
    Value = rep(NA, nrow(vwc_measured) - 1))
  for (i in seq_len(nrow(q850))) {
    q850[i, 2] <- heat_flux$HF.Bottom[i] +
      (c_sand(vwc_measured$Z750[i])) * ((t875[i + 1] - t875[i]) / 0.25) * 0.09 +
      t875[i] * ((c_sand(vwc_measured$Z750[i + 1]) - c_sand(vwc_measured$Z750[i])) / 0.25) * 0.09
  }
  # forming a dataset to store predicted temperatures
  data_predicted <- data_observed
  data_predicted[2:nrow(data_observed), 3:ncol(data_observed)] <- NA
  # estimating soil temperature
  for (j in 1:(nrow(data_observed) - 1)) {
    for (i in 3:(ncol(data_observed) - 1)) {
      data_predicted[j + 1, i] <- round(data_predicted[j, i] +
                                       (alpha[j, i] * (data_predicted[j, i + 1] - 2 * data_predicted[j, i] + data_predicted[j, i - 1]) * (0.25 * 60 * 60) / (50 * 50)) +
                                       (alpha[j, i + 1] - alpha[j, i - 1]) * (data_predicted[j, i + 1] - data_predicted[j, i - 1]) * (0.25 * 60 * 60) / (2 * 2 * 50 * 50), 2)
    }
    data_predicted[j + 1, 18] <- round(data_predicted[j, 18] +
                                      (alpha[j, 18] * (t900[j] - 2 * data_predicted[j, 18] + data_predicted[j, 17]) * (0.25 * 60 * 60) / (50 * 50)) +
                                      (q850[j, 2] * 0.25) / (c_sand(vwc$Z750[j]) * (0.05)), 2)
  }
  return(data_predicted)
}
ex1 <- numerical_experiment(1)
ex2 <- numerical_experiment(1.5)
ex3 <- numerical_experiment(2)
depth <- seq(50, 850, 50)
# RGB codes of NGIF colours
green <- rgb(157 / 256, 175 / 256, 33 / 256)
blue <- rgb(32 / 256, 137 / 256, 203 / 256)
pdf(file = "Figures/Yildiz&Stirling_2022_Fig8.pdf",
  width = (90 / 25.4), height = c(170 / 25.4))
layout(matrix(c(1, 2, 3, 4, 5, 6), nrow = 6, ncol = 1, byrow = T),
  widths = 90, heights = c(5, 5, 50, 50, 50, 10))
par(mar = c(0, 0, 0, 0), mgp = c(0.1, 0.1, 0),
  family = "serif", ps = 10, cex = 1, cex.main = 1, las = 1)
plot(0, 0, xlim = c(0, 300), ylim = c(16, 28),
  xlab = NA, ylab = NA, axes = F, pch = "")
legend("center", c("k = 1.00", "k = 1.50", "k = 2.00"),
  lwd = 1, lty = 1, col = c(1, blue, green), hor = T, bty = "n")
par(mar = c(0, 0, 0, 0), mgp = c(0.1, 0.1, 0),
  family = "serif", ps = 10, cex = 1, cex.main = 1, las = 1)
plot(0, 0, xlim = c(0, 300), ylim = c(16, 28),
  xlab = NA, ylab = NA, axes = F, pch = "")
legend("center", c("@ 650 mm", "@ 750 mm", "@ 850 mm"),
  lwd = 1, lty = c(1, 2, 3), col = c(1), hor = T, bty = "n", x.intersp  =  0.1)
par(mar = c(0.25, 2.25, 0.25, 0.25), mgp = c(0.1, 0.1, 0),
  family = "serif", ps = 10, cex = 1, cex.main = 1, las = 1)
plot(0, 0, xlim = c(0, 300), ylim = c(16, 28),
  xlab = NA, ylab = NA, axes = F, pch = "")
segments(x0 = seq(0, 288, 24), y0 = 16,
  x1 = seq(0, 288, 24), y1 = 28,
  col = "gray87")
segments(x0 = 0, y0 = seq(16, 28, 1.2),
  x1  = 288, y1 = seq(16, 28, 1.2),
  col = "gray87")
axis(1, tck = 0.02, at = seq(0, 288, 12), labels = NA)
axis(2, tck = 0.02, at = seq(16, 28, 2.4))
box()
par(las = 0)
mtext("Soil temperature [°C]", side = 2, line = 1.5)
lines(ex1$Z650[131:418], lwd = 1, col = 1)
lines(ex2$Z650[131:418], col = blue, lwd = 1, lty = 1)
lines(ex3$Z650[131:418], col = green, lwd = 1)
lines(ex1$Z750[131:418], lwd = 1, col = 1, lty = 2)
lines(ex2$Z750[131:418], col = blue, lwd = 1, lty = 2)
lines(ex3$Z750[131:418], col = green, lwd = 1, lty = 2)
lines(ex1$Z850[131:418], lwd = 2, col = 1, lty = 3)
lines(ex2$Z850[131:418], col = blue, lwd = 2, lty = 3)
lines(ex3$Z850[131:418], col = green, lwd = 2, lty = 3)
text(0, 28, "A", adj = c(0, 1), font = 2)
par(mar = c(0.25, 2.25, 0.25, 0.25), mgp = c(0.1, 0.1, 0),
  family = "serif", ps = 10, cex = 1, cex.main = 1, las = 1)
plot(0, 0, xlim = c(0, 300), ylim = c(20, 28),
  xlab = NA, ylab = NA, axes = F, pch = "")
segments(x0  = seq(0, 288, 24), y0 = 20,
  x1  = seq(0, 288, 24), y1  = 28,
  col = "gray87")
segments(x0 = 0, y0 = seq(20, 28, 0.8),
  x1  = 288, y1  = seq(20, 28, 0.8),
  col = "gray87")
axis(1, tck = 0.02, at = seq(0, 288, 12), labels = NA)
axis(2, tck = 0.02, at = seq(20, 28, 1.6))
box()
par(las = 0)
mtext("Soil temperature [°C]", side = 2, line = 1.5)
lines(ex1$Z650[803:1090], lwd = 1, col = 1, lty = 1)
lines(ex2$Z650[803:1090], col = blue, lwd = 1, lty = 1)
lines(ex3$Z650[803:1090], col = green, lwd = 1, lty = 1)
lines(ex1$Z750[803:1090], lwd = 1, col = 1, lty = 2)
lines(ex2$Z750[803:1090], col = blue, lwd = 1, lty = 2)
lines(ex3$Z750[803:1090], col = green, lwd = 1, lty = 2)
lines(ex1$Z850[803:1090], lwd = 2, col = 1, lty = 3)
lines(ex2$Z850[803:1090], col = blue, lwd = 2, lty = 3)
lines(ex3$Z850[803:1090], col = green, lwd = 2, lty = 3)
text(0, 28, "B", adj = c(0, 1), font = 2)
par(mar = c(0.25, 2.25, 0.25, 0.25), mgp = c(0.1, 0.1, 0),
  family = "serif", ps = 10, cex = 1, cex.main = 1, las = 1)
plot(0, 0, xlim = c(0, 300), ylim = c(19, 21),
  xlab = NA, ylab = NA, axes = F, pch = "")
segments(x0 = seq(0, 288, 24), y0  = 19,
  x1  = seq(0, 288, 24), y1 = 21,
  col = "gray87")
segments(x0 = 0, y0 = seq(19, 21, 0.2),
  x1 = 288, y1 = seq(19, 21, 0.2),
  col = "gray87")
axis(1, tck = 0.02, at = seq(0, 288, 12), labels = seq(0, 72, 3))
axis(2, tck = 0.02, at = seq(19, 21, 0.4))
box()
par(las = 0)
mtext("Soil temperature [°C]", side = 2, line = 1.5)
mtext("Time [h]", side = 1, line = 1)
lines(ex1$Z650[1475:1762], lwd = 1, col = 1, lty = 1)
lines(ex2$Z650[1475:1762], col = blue, lwd = 1, lty = 1)
lines(ex3$Z650[1475:1762], col = green, lwd = 1, lty = 1)
lines(ex1$Z750[1475:1762], lwd = 1, col = 1, lty = 2)
lines(ex2$Z750[1475:1762], col = blue, lwd = 1, lty = 2)
lines(ex3$Z750[1475:1762], col = green, lwd = 1, lty = 2)
lines(ex1$Z850[1475:1762], lwd = 2, col = 1, lty = 3, pch = 1)
lines(ex2$Z850[1475:1762], col = blue, lwd = 2, lty = 3)
lines(ex3$Z850[1475:1762], col = green, lwd = 2, lty = 3)
text(0, 21, "C", adj = c(0, 1), font = 2)
par(mar = c(0, 0, 0, 0), mgp = c(0.1, 0.1, 0),
  family = "serif", ps = 10, cex = 1, cex.main = 1, las = 1)
plot(0, 0, xlim = c(0, 300), ylim = c(16, 28),
  xlab = NA, ylab = NA, axes = F, pch = "")
dev.off()