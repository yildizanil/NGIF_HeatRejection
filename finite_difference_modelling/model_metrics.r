# Ground heat exchange potential of Green Infrastructure
# Yildiz,  A. and Stirling,  R.A.
# Submitted to Geothermics
# functions to assess model performance
mape <- function(y_observed, y_predicted) {
  if (length(y_observed) == length(y_predicted)) {
    n <- length(y_observed)
    metric <- 100 * (sum(abs((y_observed - y_predicted) / (y_observed))) / n)
    return(metric)
  }
  else {
    stop("Length of the observations and predictions should be equal")
  }
}
rmse <- function(y_observed, y_predicted, normalise = T) {
  if (length(y_observed) == length(y_predicted)) {
    n <- length(y_observed)
    rmse <- sqrt(sum((y_observed - y_predicted)^2) / n)
    nrmse <- 100 * rmse / mean(y_observed)
  }
  else {
    stop("Length of the observations and predictions should be equal")
  }
  if (normalise == T) {
    return(nrmse)
  } else {
    return(rmse)
  }
}
r2 <- function(y_observed, y_predicted) {
  ss_res <- sum((y_observed - y_predicted)^2)
  ss_tot <- sum((y_observed - mean(y_observed))^2)
  r2 <- 1 - (ss_res / ss_tot)
  return(r2)
}