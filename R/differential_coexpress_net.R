#' Estimate differential co-expression networks for two groups from normalized count data
#' The differential co-expression network of two groups are defined by the difference
#' of the co-expression network within each group, coupled with a permutation test to
#' threshold insigificant entries
#'
#' @param n_counts_1 normalized count of group 1
#' @param n_counts_2 normalized count of group 2
#' @param method name of the method used to estimate co-expression ("pearson" or "spearman")
#' @param rep the number of repetition for permutation test
#' @param seed set random seed to ensure reproducibility of the permutation test
#' @return a symmetric differential co-expression network
#' @import stats
#' @import utils
#' @importFrom dplyr %>%
#' @export
DifferentialNet = function(n_counts_1, n_counts_2, method = "pearson", rep = 100, seed = NULL){
  if(ncol(n_counts_1) != ncol(n_counts_2)){
    stop("Number of Genes are Different")
  }

  n1 = nrow(n_counts_1)
  n2 = nrow(n_counts_2)
  if (abs(n1 - n2) > 1000) {
    warning("Large sample size difference")
  }

  set.seed(seed)
  seeds = sample(1000:10000000, size = rep)

  p = ncol(n_counts_1)
  p_matrix = matrix(0, nrow = p, ncol = p)


  diff = cor(n_counts_1, method = method) - cor(n_counts_2, method = method)
  n_counts_full = rbind(n_counts_1, n_counts_2)
  pb = txtProgressBar(0, rep, style = 3)

  null_dist = list()
  for (i in 1:rep) {
    set.seed(seeds[i])
    ind = sample(1:(n1 + n2), size = n1 + n2, replace = F)
    n_counts = n_counts_full[ind, ]
    null_dist[[i]] = (cor(n_counts[1:n1, ], method = method) - cor(n_counts[(n1 + 1):(n1 + n2), ], method = method)) %>% abs()
    setTxtProgressBar(pb, i)
  }

  for (i in 2:p) {
    for (j in 1:(i - 1)) {
      x = diff[i, j] %>% abs()
      null_dist_x = unlist(lapply(null_dist, function(x) x[i,
                                                           j]))
      p_matrix[i, j] <- p_matrix[j, i] <- mean(null_dist_x >=
                                                 x, na.rm = T)
    }
  }

  p_matrix = MatrixBH(p_matrix)

  coexpress_net_1 = CoExpNet(n_counts_1, method)
  coexpress_net_2 = CoExpNet(n_counts_2, method)
  differential_net = coexpress_net_1 - coexpress_net_2
  differential_net[p_matrix > 0.05] = 0
  diag(differential_net) = 1

  return(differential_net/2)
}
