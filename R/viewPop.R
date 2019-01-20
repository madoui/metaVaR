viewPop <- function (p){
  if ( ncol(p)== 1 ){
    plotAF (p)
    return ( list ( pairwise=0, fst=0, LK=0, selection = 0 , varID = rownames(p)) )
  }
  else{
    pw=pwFst(p)
    f=Fst(p)
    l=LK(p)
    s=selectionTest(p)
    if ( ncol(p)== 2 ){
      par(mfrow=(c(2,1)))
      plotAF (p)
      plotLK (p)
      return ( list ( pairwise=pw, fst=f, LK=l$LK, selection = s , varID = l$varID) )
    }
    if ( ncol(p) > 2 ){
      par(mfrow=(c(3,1)))
      plotAF (p)
      plotPW (pw)
      plotLK (p)
      return ( list ( pairwise=pw, fst=f, LK=l$LK, selection = s , varID = l$varID) )
    }
  }
}
