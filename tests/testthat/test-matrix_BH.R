test_that("the matrix is symmetric after correction", {
  test_p = matrix(runif(100), 10, 10)
  test_p = (test_p + t(test_p))/2
  diag(test_p) = 1
  test_p_BH = MatrixBH(test_p)
  expect_true(mean(test_p_BH == t(test_p_BH)) == 1)
})
