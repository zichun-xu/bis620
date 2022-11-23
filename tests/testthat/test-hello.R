test_that("hello works", {
  is_hello <- hello()
  expect_true(is_hello  == "Hello!")
})


test_that("hello works with names", {
  is_hello <- hello(name = "John")
  expect_true(is_hello  == "Hello John!")
})

test_that("hello works with invisible", {
  is_hello <- hello(invisible = TRUE)
  expect_true(is_hello  == "Hello!")
})
