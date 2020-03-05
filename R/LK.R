#' LK statistics
#'
#' Compute the LK statistics from MVS allele frequencies
#' @references RC Lewontin and J Krakauer. Distribution of gene frequency as a test of the theory of the selective neutrality of polymorphisms. Genetics 74(1):175–195. 1973
#' @details The LK is computed as follow, \eqn{LK=\frac{(n-1) Fst}{mean(F_{ST})}}, where \code{F_{ST}} is the wright's F-statistics.
#' @param p allele frequencies of class \code{data.frame}
#' @return LK value of class \code{data.frame}
#' @export
LK <- function (p){
  n = ncol(p)
  fst = fst(p)
  lk = (n-1)*fst/mean(fst)
  pv = pchisq (q = lk, df = n-1, lower.tail = FALSE)
  qv = p.adjust (pv, method = "BH")
  d = cbind( names(fst), fst, lk, pv,  qv )
  colnames(d) = c( "varID", "Fst", "LK", "p_value","q_value" )
  d = as.data.frame(d)
  d = as.data.frame(apply(d, 2, function(x) as.numeric(as.character(x))))
  return ( d )
}
