test_that("each cluster has size bigger than the set minimum", {
  n_counts = readRDS(test_path("fixtures", "n_counts"))
  mat = CoExpNet(n_counts)
  clusters = Clustering(mat, 5, 5)[[1]]
  expect_equal(mean(lapply(clusters, length) >= 5), 1)
})
