# Ground heat exchange potential of Green Infrastructure
# Yildiz, A. and Stirling, R.A.
# Submitted to Geothermics
# This R file stores self-written functions used in the manuscript
# interpolation
interpolate_soil_temperature <- function(first, second, at) {
    index_first <- which(colnames(soil_temp) ==
        paste0("Z", sprintf("%03d", first)))
    index_second <- which(colnames(soil_temp) ==
        paste0("Z", sprintf("%03d", second)))
    index_at <- which(colnames(data_observed) ==
        paste0("Z", sprintf("%03d", at)))
    data_observed[, index_at] <- round(soil_temp[, index_first] +
        ((at - first) / (second - first)) *
        (soil_temp[, index_second] - soil_temp[, index_first]), 2)
    return(data_observed)
}