# Ground heat exchange potential of Green Infrastructure
# Yildiz,  A. and Stirling,  R.A.
# Submitted to Geothermics
# Step 01: importing material properties
source("FDM/01_material_properties.r")
# Step 02: preprocessing soil temperature data
source("FDM/02_preprocess_soil_temperature.r")
# Step 03: preprocessing soil temperature data
source("FDM/03_preprocess_vwc.r")
# Step 04: preprocessing thermal diffusifivity data
source("FDM/04_preprocess_thermal_diffusivity.r")
# Step 05: calculating heat flux at the lower boundary
source("FDM/05_calculate_heat_flux.r")
# Step 06: model calculation
source("FDM/06_calculate_soil_temperature.r")