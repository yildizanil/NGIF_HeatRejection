# Ground heat exchange potential of Green Infrastructure
# Yildiz,  A. and Stirling,  R.A.
# Submitted to Geothermics
# importing numerical experiment functions
source("FDM/numerical_experiments.r")
ex1 <- num_ex_k_1()
ex2 <- num_ex_k_2()
ex3 <- num_ex_k_3()
depth <- seq(50, 850, 50)
# RGB codes of NGIF colours
green <- rgb(157 / 256, 175 / 256, 33 / 256)
blue <- rgb(32 / 256, 137 / 256, 203 / 256)
pdf(file = "Figures/Yildiz&Stirling_2022_Fig8.pdf",
  width = (90 / 25.4), height = c(170 / 25.4))
layout(matrix(c(1, 2, 3, 4, 5, 6), nrow = 6, ncol = 1, byrow = T),
  widths = 90, heights = c(5, 5, 50, 50, 50, 10))
par(mar = c(0, 0, 0, 0), mgp = c(0.1, 0.1, 0),
  family = "serif", ps = 10, cex = 1, cex.main = 1, las = 1)
plot(0, 0, xlim = c(0, 300), ylim = c(16, 28),
  xlab = NA, ylab = NA, axes = F, pch = "")
legend("center", c("k = 1.00", "k = 1.50", "k = 2.00"),
  lwd = 1, lty = c(2,1,3), col = 8, hor = T, bty = "n")
par(mar = c(0, 0, 0, 0), mgp = c(0.1, 0.1, 0),
  family = "serif", ps = 10, cex = 1, cex.main = 1, las = 1)
plot(0, 0, xlim = c(0, 300), ylim = c(16, 28),
  xlab = NA, ylab = NA, axes = F, pch = "")
legend("center", c("@ 650 mm", "@ 750 mm", "@ 850 mm"),
  lwd = 1, lty = c(1), col = c(1, blue, green), hor = T, bty = "n", x.intersp  =  0.1)
par(mar = c(0.25, 2.25, 0.25, 0.25), mgp = c(0.1, 0.1, 0),
  family = "serif", ps = 10, cex = 1, cex.main = 1, las = 1)
plot(0, 0, xlim = c(0, 300), ylim = c(16, 28),
  xlab = NA, ylab = NA, axes = F, pch = "")
segments(x0 = seq(0, 288, 24), y0 = 16,
  x1 = seq(0, 288, 24), y1 = 28,
  col = "gray87")
segments(x0 = 0, y0 = seq(16, 28, 1.2),
  x1  = 288, y1 = seq(16, 28, 1.2),
  col = "gray87")
axis(1, tck = 0.02, at = seq(0, 288, 12), labels = NA)
axis(2, tck = 0.02, at = seq(16, 28, 2.4))
box()
par(las = 0)
mtext("Soil temperature [°C]", side = 2, line = 1.5)
lines(ex1$Z650[131:418], col = 1, lwd = 1, lty = 2)
lines(ex2$Z650[131:418], col = 1, lwd = 1, lty = 1)
lines(ex3$Z650[131:418], col = 1, lwd = 2, lty = 3)
lines(ex1$Z750[131:418], col = blue, lwd = 1, lty = 2)
lines(ex2$Z750[131:418], col = blue, lwd = 1, lty = 1)
lines(ex3$Z750[131:418], col = blue, lwd = 2, lty = 3)
lines(ex1$Z850[131:418], col = green, lwd = 1, lty = 2)
lines(ex2$Z850[131:418], col = green, lwd = 1, lty = 1)
lines(ex3$Z850[131:418], col = green, lwd = 2, lty = 3)
text(0, 28, "A", adj = c(0, 1), font = 2)
par(mar = c(0.25, 2.25, 0.25, 0.25), mgp = c(0.1, 0.1, 0),
  family = "serif", ps = 10, cex = 1, cex.main = 1, las = 1)
plot(0, 0, xlim = c(0, 300), ylim = c(20, 28),
  xlab = NA, ylab = NA, axes = F, pch = "")
segments(x0  = seq(0, 288, 24), y0 = 20,
  x1  = seq(0, 288, 24), y1  = 28,
  col = "gray87")
segments(x0 = 0, y0 = seq(20, 28, 0.8),
  x1  = 288, y1  = seq(20, 28, 0.8),
  col = "gray87")
axis(1, tck = 0.02, at = seq(0, 288, 12), labels = NA)
axis(2, tck = 0.02, at = seq(20, 28, 1.6))
box()
par(las = 0)
mtext("Soil temperature [°C]", side = 2, line = 1.5)
lines(ex1$Z650[803:1090], col = 1, lwd = 1, lty = 2)
lines(ex2$Z650[803:1090], col = 1, lwd = 1, lty = 1)
lines(ex3$Z650[803:1090], col = 1, lwd = 2, lty = 3)
lines(ex1$Z750[803:1090], col = blue, lwd = 1, lty = 2)
lines(ex2$Z750[803:1090], col = blue, lwd = 1, lty = 1)
lines(ex3$Z750[803:1090], col = blue, lwd = 2, lty = 3)
lines(ex1$Z850[803:1090], col = green, lwd = 1, lty = 2)
lines(ex2$Z850[803:1090], col = green, lwd = 1, lty = 1)
lines(ex3$Z850[803:1090], col = green, lwd = 2, lty = 3)
text(0, 28, "B", adj = c(0, 1), font = 2)
par(mar = c(0.25, 2.25, 0.25, 0.25), mgp = c(0.1, 0.1, 0),
  family = "serif", ps = 10, cex = 1, cex.main = 1, las = 1)
plot(0, 0, xlim = c(0, 300), ylim = c(19, 21),
  xlab = NA, ylab = NA, axes = F, pch = "")
segments(x0 = seq(0, 288, 24), y0  = 19,
  x1  = seq(0, 288, 24), y1 = 21,
  col = "gray87")
segments(x0 = 0, y0 = seq(19, 21, 0.2),
  x1 = 288, y1 = seq(19, 21, 0.2),
  col = "gray87")
axis(1, tck = 0.02, at = seq(0, 288, 12), labels = seq(0, 72, 3))
axis(2, tck = 0.02, at = seq(19, 21, 0.4))
box()
par(las = 0)
mtext("Soil temperature [°C]", side = 2, line = 1.5)
mtext("Time [h]", side = 1, line = 1)
lines(ex1$Z650[1475:1762], col = 1, lwd = 1, lty = 2)
lines(ex2$Z650[1475:1762], col = 1, lwd = 1, lty = 1)
lines(ex3$Z650[1475:1762], col = 1, lwd = 2, lty = 3)
lines(ex1$Z750[1475:1762], col = blue, lwd = 1, lty = 2)
lines(ex2$Z750[1475:1762], col = blue, lwd = 1, lty = 1)
lines(ex3$Z750[1475:1762], col = blue, lwd = 2, lty = 3)
lines(ex1$Z850[1475:1762], col = green, lwd = 1, lty = 2)
lines(ex2$Z850[1475:1762], col = green, lwd = 1, lty = 1)
lines(ex3$Z850[1475:1762], col = green, lwd = 2, lty = 3)
text(0, 21, "C", adj = c(0, 1), font = 2)
par(mar = c(0, 0, 0, 0), mgp = c(0.1, 0.1, 0),
  family = "serif", ps = 10, cex = 1, cex.main = 1, las = 1)
plot(0, 0, xlim = c(0, 300), ylim = c(16, 28),
  xlab = NA, ylab = NA, axes = F, pch = "")
dev.off()