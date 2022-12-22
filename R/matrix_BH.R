#' BH Procedure for multiple testing of a matrix
#'
#' @param p_matrix a symmetric matrix of p-values
#' @return a symmetric matrix of p-values after BH-procedure
#' @import stats
#' @export

MatrixBH = function(p_matrix){
  p_matrix_BH = p_matrix - p_matrix
  p_matrix_BH[upper.tri(p_matrix_BH)] = p.adjust(p_matrix[upper.tri(p_matrix)], method = "BH")
  return(p_matrix_BH + t(p_matrix_BH))
}
