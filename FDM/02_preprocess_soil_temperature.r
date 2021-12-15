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
data_observed <- interpolate_soil_temperature(first = 40, second = 70, at = 50)
data_observed <- interpolate_soil_temperature(first = 150,
    second = 250, at = 200)
data_observed <- interpolate_soil_temperature(first = 250,
    second = 350, at = 300)
data_observed <- interpolate_soil_temperature(first = 350,
    second = 450, at = 400)
data_observed <- interpolate_soil_temperature(first = 450,
    second = 550, at = 500)
data_observed <- interpolate_soil_temperature(first = 550,
    second = 650, at = 600)
    data_observed <- interpolate_soil_temperature(first = 650,
    second = 750, at = 700)