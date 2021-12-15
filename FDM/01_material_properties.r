# Ground heat exchange potential of Green Infrastructure
# Yildiz,  A. and Stirling,  R.A.
# Submitted to Geothermics
# defining volumetric heat capacity and thermal diffusivity of
# sand and topsoil as a function of volumetric water content
c_sand <- function(vwc) {
  (296.4 + ((52.7 + 8.32 * (vwc - 5.27)) / (1 + exp(-3.24 * (vwc - 5.27)))))
  }
a_sand <- function(vwc) {
  ((0.64 / (1 + exp(-1.72 * (vwc - 6.01)))) + 0.25)
  }
a_topsoil <- function(vwc) {
  ((0.25 / (1 + exp(-0.78 * (vwc - 11.3)))) + 0.23)
  }