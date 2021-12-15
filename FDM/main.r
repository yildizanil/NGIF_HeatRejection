# Ground heat exchange potential of Green Infrastructure
# Yildiz,  A. and Stirling,  R.A.
# Submitted to Geothermics
# importing self-written functions
source("Functions.r")
# time frame presented in the manuscript
startdate <- utc("2019-07-18 00:00:00")
enddate <- utc("2019-09-12 00:00:00")
# Step 01: importing material properties
source("FDM/material_properties.r")
# Step 02: preprocessing soil temperature data
source("FDM/preprocess_soil_temperature.r")
# Step 03: preprocessing soil temperature data
source("FDM/preprocess_vwc.r")
# Step 04: preprocessing thermal diffusifivity data
source("FDM/preprocess_thermal_diffusivity.r")
# Step 05: calculating heat flux at the lower boundary
source("FDM/calculate_heat_flux.r")
# Step 06: model calculation
source("FDM/calculate_soil_temperature.r")