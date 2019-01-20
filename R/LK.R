LK <- function (p){
  n = ncol(p)
  fst = Fst(p)
  lk = (n-1)*fst$fst/mean(fst$fst)
  return (list ( LK_val=as.vector(lk) , npop = n , varID = fst$varID) )
}
