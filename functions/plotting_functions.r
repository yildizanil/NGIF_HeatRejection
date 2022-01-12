# Ground heat exchange potential of Green Infrastructure
# Yildiz, A. and Stirling, R.A.
# Submitted to Geothermics
# This R file stores self-written functions used in the manuscript
# plotting white space with a given margin
plot_white_space <- function(margin) {
    if (!is.vector(margin)) {
       stop("Margin should be entered as a vector")
    }
    if (length(margin) != 4) {
       stop("Four entries are required, i.e. one value for each side")
    }
    if (!is.numeric(margin)) {
       stop("Margins should be entered as a numeric value")
    }
  par(mar = margin, mgp = c(0.1, 0.1, 0),
    family = "serif", ps = 10,
    cex = 1, cex.main = 1, las = 1)
  plot(0, 0, pch = "", xlab = NA, ylab = NA,
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