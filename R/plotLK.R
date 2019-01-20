plotLK <- function (p){
  l = LK(p)
  h = hist ( l$LK_val , plot = F, breaks = 50 )
  max1 = max ( h$density )
  max2 = max ( dchisq (seq(0:max(l$LK_val)), l$npop-1))
  Max = max (max1, max2) + 0.1
  hist ( l$LK_val, freq=F, main = "LK distribution", xlab="LK" , ylim = c(0,Max) , breaks = 50 )
  curve ( dchisq( x, l$npop-1 ) , lwd=3, col="orange" , add=T )
}
