#' pwFst
#'
#' Calculate pairwise F-statistics between each population
#' @references Sewal Wright. Genetical Structure of Populations. Nature, 166:247–249, 1950
#' @param p allele frequencies
#' @return pairwise Fst
#' @export

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
