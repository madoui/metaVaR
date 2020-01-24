#' fst
#'
#' Compute F-statistics from MVS allele frequencies
#' @references Sewall Wright. Genetical Structure of Populations. Nature, 166:247–249, 1950
#' @details The F-statistics is computed as follow, \eqn{F=\frac{var(p)}{mean(p)(1-mean(p))}}, where \code{p} is a vector of allele frequencies
#' @param p allele frequencies of class \code{data.frame}
#' @return F-statistics value
#' @export
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
