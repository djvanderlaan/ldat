
context("generate")

test_that("generate works", {
  set.seed(1)
  x <- generate(2E6, rnorm)
  set.seed(1)
  y <- rnorm(2E6)
  expect_that(as_rvec(x), equals(y))

  set.seed(1)
  x <- generate(2E6, function(n) sample(6, n, replace = TRUE))
  set.seed(1)
  y <- sample(6, 2E6, replace = TRUE)
  expect_that(as_rvec(x), equals(y))
})
