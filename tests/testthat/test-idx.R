
context("idx")

library(dplyr)

var1 <- rnorm(1000, mean = 5)
var2 <- rnorm(1000, mean = 5)

test_that("basic indexing", {

  idx <- idx_mean(var1, var2)

  expect_equal(idx[1], (var1[1] + var2[1]) / 2)

})

test_that("basic indexing with missing vals", {

  var2[50:100] <- NA

  idx <- idx_mean(var1, var2)

  expect_equal(var1[50] + var2[50], NA_integer_)
  expect_type(idx[50], "double")

  expect_equal((var1[1] + var2[1])/2, idx[1])
  expect_type(idx[1], "double")

  # check that NA's worked as expected
  df <- tibble(var2, var1) %>% na.omit
  fit <- .lm.fit(cbind(1, df$var1), as.matrix(df$var2))
  pred <- fit$coefficients %*% t(cbind(1, var1))
  # pred <- predict(fit, newdata = cbind(1, df$var1))
  var2_fill <- if_else(is.na(var2), pred, var2)

  expect_equal((var1[1] + var2[1]) / 2, idx[1])
  expect_equal((var1[50] + var2_fill[50]) / 2, idx[50])
  expect_equal((var1[50] + var2[50]) / 2, NA_integer_)

})
