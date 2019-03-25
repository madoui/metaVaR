#' dbscan2mvc
#'
#' Convert a dbscan ouput to metavariant clusters
#'
#' @param dbscanRes \code{dbscan} result.
#' @param cov metavaraint loci depth of coverage dataframe.
#' @param mvcMinVar minimum number of metavariants for mvc, set to 1,000 by default.
#' @param mvcMinCov minimum vamue for the median depth of coverage
#' @return a list of object of class \code{mvc}
#' @import fitdistrplus
#' @export
dbscan2mvc <- function(dbscanRes, cov, mvcMinVar = 1000, mvcMinCov = 5){
  mvcList = list()
  mvcNb = max(dbscanRes$cluster)
  popNb = ncol(cov)
  popName = colnames(cov)
  var = rownames(cov)
  for (i in 1:mvcNb){
    mvcName = paste (dbscanRes$eps, "_", dbscanRes$minPts, "_", i, sep = "")
    mvcVar = var [dbscanRes$cluster == i]
    if (length( mvcVar ) < mvcMinVar){
      next
    }
    mvcCov = cov[mvcVar,]
    mvcFit = list()
    for (j in 1:popNb){
      if (median(mvcCov[,j]< mvcMinCov)){
        next
      }
      fit = fitdist (sample(mvcCov[,j], mvcMinVar) , "nbinom", method = 'mle', silent = TRUE)
      mvcFit [[popName[j]]] = fit
    }
    mvc = mvc (name = mvcName,
               eps = dbscanRes$eps,
               pts = dbscanRes$minPts,
               var = mvcVar,
               pop = popName,
               cov = mvcCov,
               fit = mvcFit)
    mvcList[[mvc@name]]<-mvc
  }
  return (mvcList)
}
