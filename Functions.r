# Ground heat exchange potential of Green Infrastructure
# Yildiz, A. and Stirling, R.A.
# Submitted to Geothermics
# This R file stores self-written functions used in the manuscript
import_data <- function(parameter) {
    # This function imports csv files of the data stored in Figshare
    # meteo: meteorological parameters
    # vwc: volumetric water content
    # water_flux: water flux terms of lysimeter (rainfall, pet, drainage)
    # thermal_conductivity: thermal conductivity
    # soil_temperature: soil temperature
    # heat_flux: heat flux measured at the bottom and top of lysimeter
    # csv file storing the downloadlinks
    download_list <- read.csv("download_links.csv")
    # checking if the parameter is a character
    if (!is.character(parameter)) {
        stop("Parameter should be of class character")
        }
    # checking if the parameter is present in the list
    if (!parameter %in% download_list$Parameter) {
       stop("Parameter can only be ",
        paste(download_list$Parameter, collapse = ", "))
    }
    # extracting index of the parameter of interest
    index <- which(parameter == download_list$Parameter)
    # reading the csv file from Figshare
    data <- read.csv(download_list$Link[index], stringsAsFactors = F)
    # returning the data frame
    return(data)
}
# converting time series data to UTC time zone
utc <- function(x) {
        as.POSIXct(x, tz = "UTC")
        }
# plotting white space with a given margin
plot_white_space <- function(margin) {
  par(mar = margin, mgp = c(0.1, 0.1, 0),
  family = "serif", ps = 10,
  cex = 1, cex.main = 1, las = 1)
  plot(0, 0, pch = "",
  xlab = NA, ylab = NA,
  axes = F, xlim = c(0, 1), ylim = c(0, 1))
}
# adding grid lines to a custom plot
add_grid <- function(x_0, x_n, y_0, y_n, dx, dy) {
    segments(x0 = seq(x_0, x_n, dx), y0 = y_0,
        x1 = seq(x_0, x_n, dx), y1 = y_n,
        col = "gray87", lty = 1)
    segments(x0 = x_0, y0 = seq(y_0, y_n, dy),
         x1 = x_n, y1 = seq(y_0, y_n, dy),
         col = "gray87", lty = 1)
}