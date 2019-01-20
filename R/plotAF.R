plotAF <- function (x){
  boxplot ( x , main = "Population Allele frequencies" , las=2 , ylim=c(0,1) )
  abline ( h = 0.5 )
}
