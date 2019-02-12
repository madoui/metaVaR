#' tryParam
#'
#' tryParam tests several couples of epsilon and minimum points values for density-based clustering of metavariants.
#' @param eps epsilon value(s).
#' @param pts minimum points value(s).
#' @param cov depth of coverage of biallelic loci in \code{data.frame}.
#' @param mvcMinVar minimum of metavariants in \code{mcv}, set to 1,000 by default.
#' @return a list of objects of class \code{mcv}.
#' @import dbscan
#' @export
#' @examples
#' data("MS5")
#' e = c(3,5)
#' p = c(5, 10)
#' MVC = tryParam(e, p , MS5$cov) # tests (3,5), (3,10), (5,5), (5, 10)
#'
#'
#' @export

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
  cat(paste(length(eps)*length(pts)," parameters couples tested by dbscan found ",length(mvc)," mvc(s)\n", sep ="" ))
  return (mvc)
}
