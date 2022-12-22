test_that("correct dimension", {
  n_counts_1 = readRDS(test_path("fixtures", "n_counts_1"))
  n_counts_2 = readRDS(test_path("fixtures", "n_counts_2"))
  mat = DifferentialNet(n_counts_1, n_counts_2)
  expect_equal(dim(mat), c(10, 10))
})

test_that("symmetric", {
  n_counts_1 = readRDS(test_path("fixtures", "n_counts_1"))
  n_counts_2 = readRDS(test_path("fixtures", "n_counts_2"))
  mat = DifferentialNet(n_counts_1, n_counts_2)
  expect_equal(mat, t(mat))
})

test_that("correct range", {
  n_counts_1 = readRDS(test_path("fixtures", "n_counts_1"))
  n_counts_2 = readRDS(test_path("fixtures", "n_counts_2"))
  mat = DifferentialNet(n_counts_1, n_counts_2)
  expect_equal(mean(abs(mat) <= 1), 1)
})
