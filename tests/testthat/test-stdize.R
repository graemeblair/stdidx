context("standardize")

test_that("standardizing works", {

  var1 <- rnorm(1000, mean = 5)

  var1_std <- stdize(var1)

  expect_equal(mean(var1_std), 0)
  expect_equal(sd(var1_std), 1)

})
