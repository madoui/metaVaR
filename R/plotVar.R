plotVar <- function (p, v){
  par(mfrow=c(1,1))
  barplot(height = as.matrix(p[v,]),xlab = "Populations", ylab="Allele frequency")
}
