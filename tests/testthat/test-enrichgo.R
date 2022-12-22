test_that("correct number of elements", {
  n_counts = readRDS(test_path("fixtures", "n_counts"))
  mat = CoExpNet(n_counts)
  clusters = Clustering(mat, 5, 5)[[1]]
  ego = EnrichGO(clusters)
  expect_equal(unlist(lapply(ego, nrow)), c(240, 0))
})
