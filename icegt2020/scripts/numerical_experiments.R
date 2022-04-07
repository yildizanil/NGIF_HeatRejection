# Ground heat exchange potential of red Infrastructure
# Yildiz,  A. and Stirling,  R.A.
# Submitted to Geothermics
# importing self-written functions
source("functions/import_data.r")
source("functions/utc.r")
source("functions/plotting_functions.r")
source("functions/interpolate_soil_temperature.r")
# importing numerical experiment functions
source("finite_difference_modelling/numerical_experiments.r")
ex1 <- num_ex_k_1()
ex2 <- num_ex_k_2()
ex3 <- num_ex_k_3()
depth <- seq(50, 850, 50)
# RGB codes of NGIF colours
red <- rgb(241, 158, 177, maxColorValue = 256)
blue <- rgb(142, 186, 229, maxColorValue = 256)
yellow <- rgb(250, 190, 80, maxColorValue = 256)
jpeg(file = "icegt2020/figures/fig_numerical_experiment.jpg",
  width = 300, height = 140, units = "mm", res = 1000)
layout(matrix(c(1, 1, 1, 2, 2, 2, 3, 4, 5, 6, 6, 6), nrow = 4, ncol = 3, byrow = T),
  widths = c(100,100,100), heights = c(15, 15, 100, 10))
par(mar = c(0, 0, 0, 0), mgp = c(0.1, 0.1, 0),
  family = "sans", ps = 14, cex = 1, cex.main = 1, las = 1)
plot(0, 0, xlim = c(0, 300), ylim = c(16, 28),
  xlab = NA, ylab = NA, axes = F, pch = "")
legend("center", c("k = 1.00", "k = 1.50", "k = 2.00"),
  lwd = 2, lty = c(2, 1, 3), col = 8, hor = T, bty = "n")
par(mar = c(0, 0, 0, 0), mgp = c(0.1, 0.1, 0),
  family = "sans", ps = 14, cex = 1, cex.main = 1, las = 1)
plot(0, 0, xlim = c(0, 300), ylim = c(16, 28),
  xlab = NA, ylab = NA, axes = F, pch = "")
legend("center", c("@ 650 mm", "@ 750 mm", "@ 850 mm"),
  lwd = 2, lty = c(1), col = c(yellow, blue, red),
  hor = T, bty = "n", x.intersp  =  0.1)
par(mar = c(0.25, 3.5, 0.25, 0.25), mgp = c(0.1, 0.1, 0),
  family = "sans", ps = 14, cex = 1, cex.main = 1, las = 1)
plot(0, 0, xlim = c(0, 300), ylim = c(16, 28),
  xlab = NA, ylab = NA, axes = F, pch = "")
segments(x0 = seq(0, 288, 24), y0 = 16,
  x1 = seq(0, 288, 24), y1 = 28,
  col = "gray87")
segments(x0 = 0, y0 = seq(16, 28, 1.2),
  x1  = 288, y1 = seq(16, 28, 1.2),
  col = "gray87")
axis(1, tck = 0.02, at = seq(0, 288, 24), labels = NA)
axis(1, tck = 0, at = seq(0, 288, 48), labels = seq(0, 72, 12))
axis(2, tck = 0.02, at = seq(16, 28, 2.4))
box()
par(las = 0)
mtext("Soil temperature [°C]", side = 2, line = 2.5)
lines(ex1$Z650[131:418], col = yellow, lwd = 2, lty = 2)
lines(ex2$Z650[131:418], col = yellow, lwd = 2, lty = 1)
lines(ex3$Z650[131:418], col = yellow, lwd = 3, lty = 3)
lines(ex1$Z750[131:418], col = blue, lwd = 2, lty = 2)
lines(ex2$Z750[131:418], col = blue, lwd = 2, lty = 1)
lines(ex3$Z750[131:418], col = blue, lwd = 3, lty = 3)
lines(ex1$Z850[131:418], col = red, lwd = 2, lty = 2)
lines(ex2$Z850[131:418], col = red, lwd = 2, lty = 1)
lines(ex3$Z850[131:418], col = red, lwd = 3, lty = 3)
par(mar = c(0.25, 3.5, 0.25, 0.25), mgp = c(0.1, 0.1, 0),
  family = "sans", ps = 14, cex = 1, cex.main = 1, las = 1)
plot(0, 0, xlim = c(0, 300), ylim = c(20, 28),
  xlab = NA, ylab = NA, axes = F, pch = "")
segments(x0  = seq(0, 288, 24), y0 = 20,
  x1  = seq(0, 288, 24), y1  = 28,
  col = "gray87")
segments(x0 = 0, y0 = seq(20, 28, 0.8),
  x1  = 288, y1  = seq(20, 28, 0.8),
  col = "gray87")
axis(1, tck = 0.02, at = seq(0, 288, 24), labels = NA)
axis(1, tck = 0, at = seq(0, 288, 48), labels = seq(0, 72, 12))
axis(2, tck = 0.02, at = seq(20, 28, 1.6))
box()
par(las = 0)
mtext("Soil temperature [°C]", side = 2, line = 2.5)
mtext("Time [h]", side = 1, line = 1)
lines(ex1$Z650[803:1090], col = yellow, lwd = 2, lty = 2)
lines(ex2$Z650[803:1090], col = yellow, lwd = 2, lty = 1)
lines(ex3$Z650[803:1090], col = yellow, lwd = 3, lty = 3)
lines(ex1$Z750[803:1090], col = blue, lwd = 2, lty = 2)
lines(ex2$Z750[803:1090], col = blue, lwd = 2, lty = 1)
lines(ex3$Z750[803:1090], col = blue, lwd = 3, lty = 3)
lines(ex1$Z850[803:1090], col = red, lwd = 2, lty = 2)
lines(ex2$Z850[803:1090], col = red, lwd = 2, lty = 1)
lines(ex3$Z850[803:1090], col = red, lwd = 3, lty = 3)
par(mar = c(0.25, 3.5, 0.25, 0.25), mgp = c(0.1, 0.1, 0),
  family = "sans", ps = 14, cex = 1, cex.main = 1, las = 1)
plot(0, 0, xlim = c(0, 300), ylim = c(19, 21),
  xlab = NA, ylab = NA, axes = F, pch = "")
segments(x0 = seq(0, 288, 24), y0  = 19,
  x1  = seq(0, 288, 24), y1 = 21,
  col = "gray87")
segments(x0 = 0, y0 = seq(19, 21, 0.2),
  x1 = 288, y1 = seq(19, 21, 0.2),
  col = "gray87")
axis(1, tck = 0.02, at = seq(0, 288, 24), labels = NA)
axis(1, tck = 0, at = seq(0, 288, 48), labels = seq(0, 72, 12))
axis(2, tck = 0.02, at = seq(19, 21, 0.4))
box()
par(las = 0)
mtext("Soil temperature [°C]", side = 2, line = 2.5)
mtext("Time [h]", side = 1, line = 1)
lines(ex1$Z650[1475:1762], col = yellow, lwd = 2, lty = 2)
lines(ex2$Z650[1475:1762], col = yellow, lwd = 2, lty = 1)
lines(ex3$Z650[1475:1762], col = yellow, lwd = 3, lty = 3)
lines(ex1$Z750[1475:1762], col = blue, lwd = 2, lty = 2)
lines(ex2$Z750[1475:1762], col = blue, lwd = 2, lty = 1)
lines(ex3$Z750[1475:1762], col = blue, lwd = 3, lty = 3)
lines(ex1$Z850[1475:1762], col = red, lwd = 2, lty = 2)
lines(ex2$Z850[1475:1762], col = red, lwd = 2, lty = 1)
lines(ex3$Z850[1475:1762], col = red, lwd = 3, lty = 3)
par(mar = c(0, 0, 0, 0), mgp = c(0.1, 0.1, 0),
  family = "sans", ps = 14, cex = 1, cex.main = 1, las = 1)
plot(0, 0, xlim = c(0, 300), ylim = c(16, 28),
  xlab = NA, ylab = NA, axes = F, pch = "")
dev.off()