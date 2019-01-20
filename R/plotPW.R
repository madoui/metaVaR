plotPW <- function (mfst){
  plot( hclust( as.dist( mfst )), main="Populations tree" , xlab="", sub="")
}
