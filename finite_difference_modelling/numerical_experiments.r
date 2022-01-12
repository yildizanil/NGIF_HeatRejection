# Ground heat exchange potential of Green Infrastructure
# Yildiz,  A. and Stirling,  R.A.
# Submitted to Geothermics
num_ex_k_1 <- function() {
# Step 01: importing material properties
source("finite_difference_modelling/01_material_properties.r")
# Step 02: preprocessing soil temperature data
source("finite_difference_modelling/02_preprocess_soil_temperature.r")
# Step 03: preprocessing volumetric water content data
source("finite_difference_modelling/03_preprocess_vwc.r")
# Step 04: preprocessing thermal diffusifivity data
source("finite_difference_modelling/num_ex_1.r")
# Step 05: calculating heat flux at the lower boundary
source("finite_difference_modelling/05_calculate_heat_flux.r")
# Step 06: model calculation
source("finite_difference_modelling/06_calculate_soil_temperature.r")
return(data_predicted)
}
num_ex_k_2 <- function() {
# Step 01: importing material properties
source("finite_difference_modelling/01_material_properties.r")
# Step 02: preprocessing soil temperature data
source("finite_difference_modelling/02_preprocess_soil_temperature.r")
# Step 03: preprocessing volumetric water content data
source("finite_difference_modelling/03_preprocess_vwc.r")
# Step 04: preprocessing thermal diffusifivity data
source("finite_difference_modelling/num_ex_2.r")
# Step 05: calculating heat flux at the lower boundary
source("finite_difference_modelling/05_calculate_heat_flux.r")
# Step 06: model calculation
source("finite_difference_modelling/06_calculate_soil_temperature.r")
return(data_predicted)
}
num_ex_k_3 <- function() {
# Step 01: importing material properties
source("finite_difference_modelling/01_material_properties.r")
# Step 02: preprocessing soil temperature data
source("finite_difference_modelling/02_preprocess_soil_temperature.r")
# Step 03: preprocessing volumetric water content data
source("finite_difference_modelling/03_preprocess_vwc.r")
# Step 04: preprocessing thermal diffusifivity data
source("finite_difference_modelling/num_ex_3.r")
# Step 05: calculating heat flux at the lower boundary
source("finite_difference_modelling/05_calculate_heat_flux.r")
# Step 06: model calculation
source("finite_difference_modelling/06_calculate_soil_temperature.r")
return(data_predicted)
}