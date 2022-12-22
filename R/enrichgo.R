#' Obtain GO enrichment terms for a co-expressed gene modules
#'
#' @param clusters a list of gene clusters (co-expressed gene modules)
#' @param universe background genes to correct for
#' @return a list of GO enrichment results for each gene cluster
#' @importFrom  clusterProfiler enrichGO
#' @import  enrichplot
#' @import org.Hs.eg.db
#' @export
EnrichGO = function(clusters, universe = NULL){
  ego = list()
  for (i in 1:length(clusters)){
    ego[[i]] <- clusterProfiler::enrichGO(gene = clusters[[i]] ,
                         OrgDb = 'org.Hs.eg.db',
                         keyType = "SYMBOL",
                         ont = "ALL",
                         pAdjustMethod = "BH",
                         universe = universe,
                         pvalueCutoff = 0.05)
  }
  print(unlist(lapply(ego, function(x) dim(x)[1])))
  return(ego)
}
