#' tryParam
#'
#' tryParam tests several couples of epsilon and minimum points values for density-based clustering of metavariants.
#' @param eps epsilon value(s).
#' @param pts minimum points value(s).
#' @param cov depth of coverage of biallelic loci in \code{data.frame}.
#' @param mvcMinVar minimum of metavariants in \code{mcv}, set to 1,000 by default.
#' @return a list of objects of class \code{mcv}.
#' @import dbscan
#' @examples
#' \dontshow{
#' # espilon values to test for dbscan
#' e = c(3,5)
#' # minimum points values to test for dbscan
#' p = c(5,10)
#' # sampling 1000 loci from the Mediterranean variant set
#' loci = sample(rownames(MS5$cov), 10000)
#' coverage = MS5$cov[loci,]
#' # Testing dbscan parameters
#' MVC = tryParam (e, p, coverage)
#' MWIS = getMWIS (MVC)
#' frequencies = MS5$freq[loci,]
#' MVS = mvc2mvs(MWIS, freq = frequencies)
#' plotMvs(MVS[[1]], type = "heatFst")
#' }
#' \donttest{
#' # espilon values to test for dbscan
#' e = c(3,5)
#' # minimum points values to test for dbscan
#' p = c(5,10)
#' # Testing dbscan parameters
#' MVC = tryParam (e, p, MS5$cov)
#' MWIS = getMWIS (MVC)
#' MVS = mvc2mvs(MWIS, freq = MS5$freq)
#' plotMvs(MVS[[1]], type = "heatFst")
#' }
#' @export
#'
tryParam <- function ( eps, pts, cov, mvcMinVar = 1000){

  mvc = list()
  for ( i in eps ){
    for ( j in pts ){
      cat(paste("running dbscan with epsilon ", i," minimum points ", j, "...", sep = ""))
      dbscanRes = dbscan ( cov , i , j )
      newMvc = dbscan2mvc( dbscanRes, cov, mvcMinVar = mvcMinVar)
      cat (paste (" found ",length(newMvc)," mvc(s).\n"))
      mvc = c(mvc, newMvc)
    }
  }
  message(paste(length(eps)*length(pts)," parameters couples tested by dbscan found ",length(mvc)," mvc(s)\n", sep ="" ))
  return (mvc)
}
