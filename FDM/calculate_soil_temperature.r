# Ground heat exchange potential of Green Infrastructure
# Yildiz,  A. and Stirling,  R.A.
# Submitted to Geothermics
data_predicted <- data_observed
data_predicted[2:nrow(data_observed), 3:ncol(data_observed)] <- NA
# estimating soil temperature
for (j in 1:(nrow(data_observed) - 1)) {
  for (i in 3:(ncol(data_observed) - 1)) {
    data_predicted[j + 1, i] <- round(data_predicted[j, i] +
                                     (alpha[j, i] * (data_predicted[j, i + 1] - 2 * data_predicted[j, i] + data_predicted[j, i - 1]) * (0.25 * 60 * 60) / (50 * 50)) +
                                     (alpha[j, i + 1] - alpha[j, i - 1]) * (data_predicted[j, i + 1] - data_predicted[j, i - 1]) * (0.25 * 60 * 60) / (2 * 2 * 50 * 50), 2)
  }
  data_predicted[j + 1, 18] <- round(data_predicted[j, 18] +
                                      (alpha[j, 18] * (t900[j] - 2 * data_predicted[j, 18] + data_predicted[j, 17]) * (0.25 * 60 * 60) / (50 * 50)) +
                                      (q850[j, 2] * 0.25) / (c_sand(vwc$Z750[j]) * (0.05)), 2)
}