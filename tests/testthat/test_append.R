
context("Append")

test_that("append.lvec works", {
  x <- as_lvec(1:10)
  y <- 11
  z <- append(x, y)
  expect_that(as_rvec(z), equals(1:11))
  expect_that(as_rvec(x), equals(1:10))
  expect_that(lvec_type(z), equals(lvec_type(x)))

  y <- 1:10
  z <- append.lvec(NULL, y)
  expect_that(as_rvec(z), equals(1:10))

  x <- as_lvec(1:10)
  y <- 11
  z <- append(x, y, clone = FALSE)
  expect_that(as_rvec(z), equals(1:11))
  expect_that(as_rvec(x), equals(1:11))
  expect_that(lvec_type(z), equals(lvec_type(x)))


  x <- as_lvec(c("foo", "bar"))
  y <- "foobar"
  z <- append(x, y)
  expect_that(as_rvec(z), equals(c("foo", "bar", "foobar")))
})

