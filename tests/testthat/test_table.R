
context("table")

test_that("table works", {
  x <- generate(2E6, sample, x = 10, replace = TRUE)
  t <- table.lvec(Var1 = x, Var2 = x, useNA = "no")
  t_r <- table(Var1 = as_rvec(x), Var2 = as_rvec(x))
  expect_that(t, equals(t_r))
  
  # With useNA = "always
  t <- table.lvec(Var1 = x, Var2 = x, useNA = "always")
  t_r <- table(Var1 = as_rvec(x), Var2 = as_rvec(x), useNA = "always")
  expect_that(t, equals(t_r))
  
  # With missing values
  x <- generate(2E6, sample, x = c(10, NA), replace = TRUE)
  t <- table.lvec(Var1 = x, Var2 = x, useNA="no")
  t_r <- table(Var1 = as_rvec(x), Var2 = as_rvec(x))
  expect_that(t, equals(t_r))

  # With missing values
  x <- generate(2E6, sample, x = c(10, NA), replace = TRUE)
  t <- table.lvec(Var1 = x, Var2 = x)
  t_r <- table(Var1 = as_rvec(x), Var2 = as_rvec(x), useNA = "ifany")
  expect_that(t, equals(t_r))
  
})
