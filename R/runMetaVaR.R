runMetaVaR <- function ( Eps, Pts, Cov, Freq, Outdir){
  res = list()
  dir.create( Outdir, showWarnings = FALSE)
  for ( eps in Eps ){
    for ( pts in Pts ){
      test = paste( "eps" ,eps, "minPts", pts, sep="" )
      print (test, quote = F)
      prefix = c(paste(Outdir,"/", test, sep=""))
      dir.create( prefix, showWarnings = FALSE)
      dbscanRes = dbscan ( Cov , eps , pts )
      res [[test]] = checkClusters ( Cov, dbscanRes , prefix )
      cls2gen( res [[test]], Freq, prefix)
    }
  }
  return (res)
  # select best param

}
