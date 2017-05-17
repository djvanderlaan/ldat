
context("slice_range")

test_that("slice_range works for lvec objects", {
  x <- as_lvec(1:20)
  
  expect_that(as_rvec(slice_range(x, c(5,7))), equals(5:7))
  expect_that(as_rvec(slice_range(x, begin = 5, end = 7)), equals(5:7))
  expect_that(as_rvec(slice_range(x, begin = 5, end = 7, range = c(1,10))), 
    equals(5:7))
  
  expect_that(slice_range(x, c(5,7), as_r = TRUE), equals(5:7))
  expect_that(slice_range(x, begin = 5, end = 7, as_r = TRUE), equals(5:7))
  expect_that(slice_range(x, begin = 5, end = 7, range = c(1,10), as_r = TRUE), 
    equals(5:7))
  
  expect_error(slice_range(x, range = c(1, 30)))
  expect_error(slice_range(x, range = c(-11, 7)))
  expect_error(slice_range(x, range = c(NA, 7)))
})


test_that("slice_range works for lvec objects", {
  x <- 1:10
  
  expect_that(as_rvec(slice_range(x, c(5,7))), equals(5:7))
  expect_that(as_rvec(slice_range(x, begin = 5, end = 7)), equals(5:7))
  expect_that(as_rvec(slice_range(x, begin = 5, end = 7, range = c(1,10))), 
    equals(5:7))
  
  expect_error(slice_range(x, range = c(1, 30)))
  expect_error(slice_range(x, range = c(-11, 7)))
  expect_error(slice_range(x, range = c(NA, 7)))
})


test_that("slice_range works for lvec objects", {
  x <- data.frame(x = 1:20, y = letters[1:20])
  
  expect_that(as_rvec(slice_range(x, c(5,7))), equals(x[5:7, ]))
  expect_that(as_rvec(slice_range(x, begin = 5, end = 7)), equals(x[5:7, ]))
  expect_that(as_rvec(slice_range(x, begin = 5, end = 7, range = c(1,10))), 
    equals(x[5:7, ]))
  
  expect_error(slice_range(x, range = c(1, 30)))
  expect_error(slice_range(x, range = c(-11, 7)))
  expect_error(slice_range(x, range = c(NA, 7)))
})
