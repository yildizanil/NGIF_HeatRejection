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
    download_list <- read.csv("download_links.csv", stringsAsFactors = F)
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