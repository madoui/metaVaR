#' Loci fitering by coberage
#'
#' Filtering of variable loci dependending on the expected depth of coverage
#' @param cov depth of coverage
#' @param dev number of standard deviation
#' @param minCov minimum depth of coverage
#' @return depth of coverage
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
#' # Testing dbscan parameters
#' MVC = tryParam (e, p, coverage)
#' Cov = varFilterbyCov (MVC[[1]]@cov)
#' }
#' \donttest{
#' # espilon values to test for dbscan
#' e = c(3,5)
#' # minimum points values to test for dbscan
#' p = c(5,10)
#' # Testing dbscan parameters
#' MVC = tryParam (e, p, MS5$cov)
#' Cov = varFilterbyCov (MVC[[1]]@cov)
#' }
varFilterbyCov <- function  (cov , dev = 2, minCov = 8 ){
  N = nrow(cov)
  M = ncol(cov)
  sd = apply (cov , 2, sd)
  med = apply (cov , 2, median)
  covOk = matrix (rep ( 0, N*M), nrow = N, ncol = M )
  rownames (covOk) = rownames (cov)
  for (i in 1:N){
    for (j in 1:M){
      if ( cov[i,j] > med[j]-dev*sd[j] && cov[i,j] < med[j]+dev*sd[j] && cov[i,j] > minCov ){
        covOk[i,j] = 1
      }
    }
  }
  okVar = apply ( covOk , 1, function (x) all ( x == 1 ) )
  cov = cov[ okVar == 1, ]
  return (cov)
}
