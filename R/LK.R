#' LK statistics
#'
#' Compute the LK statistics from MVS allele frequencies
#' @references RC Lewontin and J Krakauer. Distribution of gene frequency as a test of the theory of the selective neutrality of polymorphisms. Genetics 74(1):175–195. 1973
#' @details The LK is computed as follow, \eqn{LK=\frac{(n-1) Fst}{mean(F_{ST})}}, where \code{F_{ST}} is the wright's F-statistics.
#' @param p allele frequencies of class \code{data.frame}
#' @return LK value of class \code{data.frame}
#' @export
#' @examples
#' \dontshow{
#' # espilon values to test for dbscan
#' e = c(3,5)
#' # minimum points values to test for dbscan
#' p = c(5,10)
#' # sampling 1000 loci from the Mediterranean variant set
#' loci = sample(rownames(MS5$cov), 10000)
#' coverage = MS5$cov[loci,]
#'
#' # Testing dbscan parameters
#' MVC = tryParam (e, p, coverage)
#' MWIS = getMWIS (MVC)
#' frequencies = MS5$freq[loci,]
#' MVS = mvc2mvs(MWIS, freq = frequencies)
#'
#' # LK-statistics
#' LK = LK(MVS[[1]]@freq)
#' }
#' \donttest{
#' # espilon values to test for dbscan
#' e = c(3,5)
#' # minimum points values to test for dbscan
#' p = c(5,10)
#'
#' # Create and MVC and MVS
#' MVC = tryParam (e, p, MS5$cov)
#' MWIS = getMWIS (MVC)
#' MVS = mvc2mvs(MWIS, freq = MS5$freq)
#'
#' # LK-statistics
#' LK = LK(MVS[[1]]@freq)
#' hist(LK)
#' }
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
