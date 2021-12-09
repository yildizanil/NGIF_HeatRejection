# Ground heat exchange potential of Green Infrastructure
# Yildiz,  A. and Stirling,  R.A.
# Submitted to Geothermics
# Function to convert time data to POSIXct data with UTC time zone
utc <- function(x) {
  as.POSIXct(x,  tz  =  "UTC")
  }
# time frame presented in the manuscript
startdate <- utc("2019-07-18 00:00:00")
enddate <- utc("2019-09-12 00:00:00")
# defining volumetric heat capacity and thermal diffusivity of
# sand and topsoil as a function of volumetric water content
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
                                  ncol = length(depth) + 1),
                                row.names  =  NULL)
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
                        ncol = length(depth) + 1),
                  row.names  =  NULL)
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
# functions to assess model performance
mape <- function(y_observed, y_predicted) {
  if (length(y_observed) == length(y_predicted)) {
    n <- length(y_observed)
    metric <- 100 * (sum(abs((y_observed - y_predicted) / (y_observed))) / n)
    return(metric)
  }
  else {
    stop("Length of the observations and predictions should be equal")
  }
}
rmse <- function(y_observed, y_predicted, normalise = T) {
  if (length(y_observed) == length(y_predicted)) {
    n <- length(y_observed)
    rmse <- sqrt(sum((y_observed - y_predicted)^2) / n)
    nrmse <- 100 * rmse / mean(y_observed)
  }
  else {
    stop("Length of the observations and predictions should be equal")
  }
  if (normalise == T) {
    return(nrmse)
  } else {
    return(rmse)
  }
}
r2 <- function(y_observed, y_predicted) {
  ss_res <- sum((y_observed - y_predicted)^2)
  ss_tot <- sum((y_observed - mean(y_observed))^2)
  r2 <- 1 - (ss_res / ss_tot)
  return(r2)
}
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
  segments(x0 = seq(startdate, enddate, 60 * 60 * 24), y0 = 10,
    x1 = seq(startdate, enddate, 60 * 60 * 24), y1 = 30, col = "gray87")
  segments(x0 = startdate, y0 = seq(10, 30, 5),
    x1 = enddate, y1 = seq(10, 30, 5), col = "gray87")
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
