# Ground heat exchange potential of Green Infrastructure
# Yildiz,  A. and Stirling,  R.A.
# Submitted to Geothermics
# importing self-written functions
source("Functions.r")
# time frame presented in the manuscript
startdate <- utc("2019-07-18 00:00:00")
enddate <- utc("2019-09-12 00:00:00")
# importing datasets from the repository
soil_temp <- import_data("soil_temperature")
heat_flux <- import_data("heat_flux")
vwc_measured <- import_data("vwc")
# calculating heat flux at the lower boundary, q850
t875 <- rowMeans(soil_temp[, c(13, 14)], na.rm = T)
t900 <- soil_temp$Z900
q850 <- data.frame(Time = vwc_measured[seq_len(nrow(vwc_measured) - 1), 1],
                  Value = rep(NA, nrow(vwc_measured) - 1))
for (i in seq_len(nrow(q850))) {
  q850[i, 2] <- heat_flux$HF.Bottom[i] +
    (c_sand(vwc_measured$Z750[i])) * ((t875[i + 1] - t875[i]) / 0.25) * 0.09 +
    t875[i] * ((c_sand(vwc_measured$Z750[i + 1]) - c_sand(vwc_measured$Z750[i])) / 0.25) * 0.09
}