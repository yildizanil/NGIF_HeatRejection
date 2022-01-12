# Ground heat exchange potential of Green Infrastructure
# Yildiz,  A. and Stirling,  R.A.
# Submitted to Geothermics
# importing self-written functions
source("functions/import_data.r")
source("functions/interpolate_soil_temperature.r")
source("functions/utc.r")
# time frame presented in the manuscript
startdate <- utc("2019-07-18 00:00:00")
enddate <- utc("2019-09-12 00:00:00")
# importing datasets from the repository
vwc_measured <- import_data("vwc")
# creating a dataset for observations
depth <- sprintf("%03d", seq(50, 850, 50))
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