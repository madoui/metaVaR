#' fst
#'
#' Calculate Fst value as \eqn{\fract{var(p)}{mean(p)(1-mean(p))}}
#' @param p allele frequencies
#' @return Fst
#' @export
fst <- function (p) {
  varID = rownames(p)
  fst = apply( p, 1, function (x) var(x)/(mean(x)*(1-mean(x))) )
  fst[ fst > 1 ] = 1
  varID = varID [complete.cases( fst )]
  varID = varID [!is.na(fst)]
  fst[complete.cases( fst )]
  fst = na.omit( fst)
  return (fst = as.vector( fst ) )
}
