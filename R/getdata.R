#' Get the normalized count data for a cell type and disease status
#'
#' @param genes index or names of the genes to be analyzed
#' @param dir directory of the dataset
#' @param cell_type one of c("Ex", "Mic", "Oli", "Ast", "In")
#' @param status one of c("AD", "NC")
#' @export
GetData = function(genes, dir = "data-raw//snRNA_seq_PNAS_AD.rds", cell_type = "Ex", status = "NC"){
  dat = readRDS(dir)
  n_count = t(as.matrix(dat[[1]]))[,genes]
  meta_data = dat[[2]]
  meta_data$disease = sapply(meta_data$sample, function(or) substr(strsplit(or, '_')[[1]][2], 1, 2))
  n_count = n_count[meta_data$cell.type == cell_type & meta_data$disease == status, ]
  return(n_count)
}
