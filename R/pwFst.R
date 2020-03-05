#' pairwise F-statistics
#'
#' Calculate pairwise F-statistics between each population of a MVS
#' @references Sewal Wright. Genetical Structure of Populations. Nature, 166:247–249, 1950
#' @param p allele frequencies (data.frame) with row and column names
#' @return \code{data.frame} of symetric pairwise F-statistics
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
#' # MVC and MVS creation
#' MVC = tryParam (e, p, coverage)
#' MWIS = getMWIS (MVC)
#' frequencies = MS5$freq[loci,]
#' MVS = mvc2mvs(MWIS, freq = frequencies)
#'
#' # pairwise-FST
#' pwFst(MVS[[1]]@freq)
#'
#' }
#' \donttest{
#' # espilon values to test for dbscan
#' e = c(3,5)
#' # minimum points values to test for dbscan
#' p = c(5,10)
#'
#' # MVC and MVS creation
#' MVC = tryParam (e, p, MS5$cov)
#' MWIS = getMWIS (MVC)
#' MVS = mvc2mvs(MWIS, freq = MS5$freq)
#'
#' # Pairwie-FST
#' pwFst(MVS[[1]]@freq)
#' plotMvs(MVS[[1]], type = "heatFst")
#'
#' }
pwFst <- function (p){
  #check if the input is a matrix
  if ( is.matrix (p) == 1){
    return (paste (substitute(x),"is a matrix"))
  }

  #create an empty matrix filled with 1
  mfst = matrix( rep( 0, ncol(p)^2), nrow = ncol(p), ncol = ncol(p) )
  popName = colnames(p)
  colnames(mfst) = popName
  rownames(mfst) = popName
  max = ncol(p)

  #compute pairwise Fst
  for (i in 1:max ){
    for ( j in i+1:max ){
      if ( j>max || i == j ){
        break
      }
      else{
        fst =  fst( data.frame( p[,i], p[,j] ) )
        mfst[i,j] = median(fst)
        mfst[j,i] = median(fst)
      }
    }
  }
  return (as.data.frame(mfst))
}
