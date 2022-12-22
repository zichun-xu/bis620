#' Estimate co-expression networks with Pearson or Spearman correlation from normalized count data
#'
#' @param n_counts normalized count
#' @param method name of the method used to estimate co-expression ("pearson" or "spearman")
#' @return a symmetric co-expression network
#' @import stats
#' @export

CoExpNet = function(n_counts, method = "pearson"){
  n = nrow(n_counts)
  p = ncol(n_counts)
  rho = cor(n_counts, method = method)
  test = abs(rho*sqrt((n-2)/(1-rho^2)))
  p_value = MatrixBH(pnorm(test, lower.tail = F))
  coexpress_net = rho
  coexpress_net[p_value > 0.05] = 0
  diag(coexpress_net) = 1
  return(coexpress_net)
}
