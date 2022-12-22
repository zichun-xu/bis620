test_that("correct dimension", {
  n_counts = readRDS(test_path("fixtures", "n_counts"))
  mat = CoExpNet(n_counts)
  expect_equal(dim(mat), c(100, 100))
})

test_that("symmetric", {
  n_counts = readRDS(test_path("fixtures", "n_counts"))
  mat = CoExpNet(n_counts)
  expect_equal(mat, t(mat))
})

test_that("correct range", {
  n_counts = readRDS(test_path("fixtures", "n_counts"))
  mat = CoExpNet(n_counts)
  expect_equal(mean(abs(mat) <= 1), 1)
})
