#' Obtain co-expressed gene modules from co-expression networks
#'
#' @param adj a symmetric adjacency matrix (co-expression network)
#' @param num_clusters the total number of clusters
#' @param min_size the minimum size of a cluster to be preserved
#' @return a list of two components, the first component is the cluster assignments of all genes,
#' the second component is the members in each cluster
#' @import stats
#' @export
Clustering = function(adj, num_clusters = 10, min_size = 10){
  genes = rownames(adj)
  cluster_mat = abs(adj)
  dist_cor = dist(cluster_mat)
  hclust_dist = hclust(dist_cor, method = "average")
  memb = cutree(hclust_dist, num_clusters)
  memb_tab = table(memb)
  print(memb_tab)
  major_clusters = names(memb_tab)[memb_tab > min_size]
  clusters = lapply(major_clusters, function(i_k) names(which(memb == i_k)))
  return(list(clusters = clusters, memb = memb))
}
