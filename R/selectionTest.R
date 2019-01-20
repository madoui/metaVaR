selectionTest <- function (p){
  l = LK(p)
  pv = pchisq (q = l$LK, df = l$npop, lower.tail = F)
  qv = p.adjust (pv, method = "BH")
  sel = data.frame( l$varID, l$LK, pv, qv )
  colnames(sel) = c( "varID", "LK","p_value","q_value" )
  return (sel)
}
