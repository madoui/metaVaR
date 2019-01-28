#' tryParam
#' Test several couples of epsilon and minimum points for density-based clustering of metavariants
#' @export
#' @param eps epsilon value(s).
#' @param pts minimum points value(s).
#' @param cov dataframe of the depth of coverage of biallelic loci.
#' @param mvcMinVar minimum of metavariants in \code{mcv}, set to 1,000 by default.
#' @return a list of object of class \code{mcv}
#' @import dbscan
#' @examples {
#' data("MS5")
#' e = c(3,4)
#' p = c(10, 20)
#' #test couples (3,10), (4,10), (3, 20), (4,20)
#  MVC = tryParam(e, p , MS5$cov)
#' }
#'
#' @export

tryParam <- function ( eps, pts, cov, mvcMinVar = 1000){
  mvc = list()
  for ( i in eps ){
    for ( j in pts ){
      cat(paste("running dbscan with epsilon ",i," minimum points ",j, "...", sep = ""))
      dbscanRes = dbscan ( cov , i , j )
      newMvc = dbscan2mvc(dbscanRes,cov, mvcMinVar = mvcMinVar)
      cat (paste (" found ",length(newMvc)," mvc(s).\n"))
      mvc = c(mvc, newMvc)
    }
  }
  cat(paste(length(eps)*length(pts)," parameters couples tested by dbscan found ",length(mvc)," mvc(s)\n", sep ="" ))
  return (mvc)
}
