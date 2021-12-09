# Ground heat exchange potential of Green Infrastructure
# Yildiz,  A. and Stirling,  R.A.
# Submitted to Geothermics
# Function to convert time data to POSIXct data with UTC time zone
utc <- function(x) {
  as.POSIXct(x,  tz = "UTC")
  }
# function to plot whitespace in complex layouts
plot_white_space <- function(margin) {
  par(mar = margin, mgp = c(0.1, 0.1, 0),
  family = "serif", ps = 10,
  cex = 1, cex.main = 1, las = 1)
  plot(0, 0, pch = "",
  xlab = NA, ylab = NA,
  axes = F, xlim = c(0, 1), ylim = c(0, 1))
}
# time frame presented in the manuscript
startdate <- utc("2019-07-18 00:00:00")
enddate <- utc("2019-09-12 00:00:00")
# defining volumetric heat capacity and thermal diffusivity of sand and topsoil
# as a function of volumetric water content
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
vwc <- data.frame(matrix(NA, nrow = nrow(vwc_measured), ncol = length(depth) + 1),
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
depth <- seq(50, 850, 50)
time <- seq(startdate, enddate, 60 * 60 * 0.25)
temp <- seq(10, 30, 1)
axis_seq <- as.character(seq.Date(as.Date(startdate), as.Date(enddate), "week"))
axis_names <- paste0(substr(axis_seq, start = 9, stop = 10), "-",
  substr(axis_seq, start = 6, stop = 7))
axis_ticks1 <- as.POSIXct(axis_seq, "UTC")
axis_ticks2 <- seq(startdate, enddate, 60 * 60 * 24)
# plotting Figure 9
png(file = "Figures/Yildiz&Stirling_2022_Fig9.png", width = 150, height = 110,
  units = "mm", res = 1000)
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
    rect(xleft = as.POSIXct(data_predicted[i, 1], "UTC"), ybottom = depth[j] - 25,
         xright = as.POSIXct(data_predicted[i + 1, 1], "UTC"), ytop = depth[j] + 25,
         col = viridis::plasma(20)[findInterval(data_predicted[i, j + 1], temp)], border = NA)
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