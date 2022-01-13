# PLEXUS @ NGIF - Heat rejection

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/yildizanil/ngif_heat_rejection/HEAD)

This repository contains the scripts used in the publication "Ground heat exchange potential of Green Infrastructure" by Anil Yildiz & Ross A. Stirling. R scripts used in numerical modelling is listed in the folder "[finite_difference_modelling](https://github.com/yildizanil/NGIF_HeatRejection/tree/main/finite_difference_modelling)". Files used to predict the soil temperature are:

- [00_main.r](https://github.com/yildizanil/NGIF_HeatRejection/blob/main/finite_difference_modelling/00_main.r)
- [01_material_properties.r](https://github.com/yildizanil/NGIF_HeatRejection/blob/main/finite_difference_modelling/01_material_properties.r)
- [02_preprocess_soil_temperature.r](https://github.com/yildizanil/NGIF_HeatRejection/blob/main/finite_difference_modelling/02_preprocess_soil_temperature.r)
- [03_preprocess_vwc.r](https://github.com/yildizanil/NGIF_HeatRejection/blob/main/finite_difference_modelling/03_preprocess_vwc.r)
- [04_preprocess_thermal_díffusivity.r](https://github.com/yildizanil/NGIF_HeatRejection/blob/main/finite_difference_modelling/04_preprocess_thermal_díffusivity.r)
- [05_calculate_heat_flux.r](https://github.com/yildizanil/NGIF_HeatRejection/blob/main/finite_difference_modelling/05_calculate_heat_flux.r)
- [06_calculate_soil_temperature.r](https://github.com/yildizanil/NGIF_HeatRejection/blob/main/finite_difference_modelling/06_calculate_soil_temperature.r)

The file [00_main.r](https://github.com/yildizanil/NGIF_HeatRejection/blob/main/finite_difference_modelling/00_main.r) can be executed to reproduce the model outcomes. Error metrics used in the publication are stored as individual functions in [model_metrics.r](https://github.com/yildizanil/NGIF_HeatRejection/blob/main/finite_difference_modelling/model_metrics.r).

The scripts used to produce the figures in the publication are listed in the main branch:

- [yildiz_and_stirling_2022_fig4.R](https://github.com/yildizanil/NGIF_HeatRejection/blob/main/figure_scripts/yildiz_and_stirling_2022_fig4.R)
- [yildiz_and_stirling_2022_fig5.R](https://github.com/yildizanil/NGIF_HeatRejection/blob/main/figure_scripts/yildiz_and_stirling_2022_fig5.R)
- [yildiz_and_stirling_2022_fig6.R](https://github.com/yildizanil/NGIF_HeatRejection/blob/main/figure_scripts/yildiz_and_stirling_2022_fig6.R)
- [yildiz_and_stirling_2022_fig7.R](https://github.com/yildizanil/NGIF_HeatRejection/blob/main/figure_scripts/yildiz_and_stirling_2022_fig7.R)
- [yildiz_and_stirling_2022_fig8.R](https://github.com/yildizanil/NGIF_HeatRejection/blob/main/figure_scripts/yildiz_and_stirling_2022_fig8.R)
- [yildiz_and_stirling_2022_fig9.R](https://github.com/yildizanil/NGIF_HeatRejection/blob/main/figure_scripts/yildiz_and_stirling_2022_fig9.R)
- [yildiz_and_stirling_2022_fig10.R](https://github.com/yildizanil/NGIF_HeatRejection/blob/main/figure_scripts/yildiz_and_stirling_2022_fig10.R)

A reproducible version of the publication is available as a Jupyter Notebook.

[Yildiz & Stirling (2022) - Ground heat exchange potential of Green Infrastructure.ipynb](https://github.com/yildizanil/NGIF_HeatRejection/blob/main/Yildiz%20%26%20Stirling%20(2022)%20-%20Ground%20heat%20exchange%20potential%20of%20Green%20Infrastructure.ipynb)
