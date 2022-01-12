# Ground heat exchange potential of Green Infrastructure
# Yildiz, A. and Stirling, R.A.
# Submitted to Geothermics
# This R file stores self-written functions used in the manuscript
# converting time series data to UTC time zone
utc <- function(date_and_time) {
    if (!is.character(date_and_time)) {
        stop("date_and_time should be a string")
    }
    as.POSIXct(date_and_time, tz = "UTC")
}