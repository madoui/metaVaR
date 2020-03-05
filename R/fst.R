#' F-statistics
#'
#' Compute F-statistics from MVS allele frequencies
#' @references Sewall Wright. Genetical Structure of Populations. Nature, 166:247–249, 1950
#' @details The F-statistics is computed as follow, \eqn{F=\frac{var(p)}{mean(p)(1-mean(p))}}, where \code{p} is a vector of allele frequencies
#' @param p allele frequencies of class \code{data.frame}
#' @return \code{vector} of F-statistics values
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
#' # F-statistics
#' FST =fst(MVS[[1]]@freq)
#'
#'
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
#' # F-statistics
#' FST = Fst(MVS[[1]]@freq)
#' hist(FST)
#' }
fst <- function (p) {
  varID = rownames(p)
  fst = apply( p, 1, function (x) var(x)/(mean(x)*(1-mean(x))) )
  fst[ fst > 1 ] = 1
  varID = varID [complete.cases( fst )]
  varID = varID [!is.na(fst)]
  fst[complete.cases( fst )]
  fst = na.omit( fst)
  fst = as.vector( fst )
  names(fst) = varID
  return ( fst =  fst )
}
