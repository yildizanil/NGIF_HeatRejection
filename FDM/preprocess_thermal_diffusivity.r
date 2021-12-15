# Ground heat exchange potential of Green Infrastructure
# Yildiz,  A. and Stirling,  R.A.
# Submitted to Geothermics
# importing self-written functions
source("Functions.r")
# time frame presented in the manuscript
startdate <- utc("2019-07-18 00:00:00")
enddate <- utc("2019-09-12 00:00:00")
# importing thermal properties
source("FDM/material_properties.r")
# preprocessing volumetric water content data
source("FDM/preprocess_vwc.r")
# forming a dataset to store thermal diffusivity
alpha <- as.data.frame(matrix(NA, nrow = nrow(vwc), ncol = ncol(vwc)))
colnames(alpha) <- colnames(vwc)
alpha[, 1] <- vwc$Time
alpha[, 2:3] <- a_topsoil(vwc[, 2:3])
alpha[, 5:18] <- a_sand(vwc[, 5:18])
alpha[, 4] <- rowMeans(cbind(a_topsoil(vwc[, 3]), a_sand(vwc[, 5])))
