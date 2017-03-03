
context("Math")

test_math <- function(fun, x, ...) {
  a <- fun(x)
  b <- as_rvec(fun(as_lvec(x)))
  expect_equal(a, b)
}

test_that("numeric operators work", {
  set.seed(1)
  x <- rnorm(2E6)
  x[c(1.3E6, 1.4E6)] <- NA

  functions <- list(`abs`, `sign`, `floor`, `ceiling`, `trunc`,
    `round`, `signif`, `exp`, `expm1`, `cos`, `sin`, `tan`,
    `cospi`, `sinpi`, `tanpi`, `atan`, `cosh`, `sinh`, `tanh`,
    `asinh`, `lgamma`, `gamma`, `digamma`, `trigamma`,
    `cumsum`, `cumprod`, `cummax`, `cummin`)

  pos_functions <- list(`sqrt`, `log`, `log1p`)
  one_functions <- list(`acos`, `asin`, `atanh`)

  for (fun in functions) {
    test_math(fun, x)
  }
  # x > 0
  for (fun in pos_functions) {
    test_math(fun, abs(x))
  }
  # x >= -1, x <= 1
  for (fun in one_functions) {
    test_math(fun, x/max(abs(x), na.rm=TRUE))
  }
  # x > 1
  test_math(acosh, abs(x) + 1)
})

