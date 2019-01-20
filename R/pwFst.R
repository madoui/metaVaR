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
        fst =  Fst( data.frame( p[,i], p[,j] ) )
        mfst[i,j] = median(fst$fst)
        mfst[j,i] = median(fst$fst)
      }
    }
  }
  return (mfst)
}
