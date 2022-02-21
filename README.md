# PLEXUS @ NGIF - Heat injection

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/yildizanil/ngif_heat_injection/HEAD)

[![badge](https://img.shields.io/badge/doi-10.1016/j.geothermics.2022.102351-E66581.svg?logo=data:image/png;base64,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)](https://doi.org/10.1016/j.geothermics.2022.102351)

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

[Yildiz & Stirling (2022) - Ground heat exchange potential of Green Infrastructure.ipynb](https://github.com/yildizanil/ngif_heat_injection/blob/main/yildiz_and_stirling_2022.ipynb)
