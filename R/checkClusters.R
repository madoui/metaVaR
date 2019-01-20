checkClusters <-function (Cov, cl, pref, minCov = 8, minVar = 1000, minPop = 4){
  nbCluster = max(cl$cluster)
  nbPop = ncol(Cov)
  popName = colnames(Cov)
  varName = rownames(Cov)
  varSets = list()
  headFit = c("cluster", "nVar", "population", "size", "mu", "logLik", "aic", "bic", "dip.test.pval")
  allFit = headFit
  options(warn=-1)
  #for each dbscan cluster, test for minCov, minvar and minPop cutoff and coverage distribution
  for (i in 1:nbCluster){
    clName = paste ("cluster_", i, sep = "")
    ClVarName = varName [cl$cluster == i]
    nbVar = length( ClVarName )
    if (nbVar < minVar){
      next
    }

    popCol = c( rep( "white", nbPop ) )
    allMedPopCov = c( rep( 0, nbPop ) )

    #output dir for the cluster
    cldir = paste( pref, "/",clName,"_", nbVar, "/", sep = "" )
    dir.create( cldir, showWarnings = FALSE)
    #for each population
    clFit = headFit
    for ( j in 1:nbPop ){
      popCov = Cov[ cl$cluster == i, j ]
      medPopCov = median ( popCov )
      allMedPopCov[j] = medPopCov

      #if the cluster has a median cov > min_cov, and more than min_var variants
      if( medPopCov >= minCov ){
        popCol[j] = "orange"
        # test the fitting with a negative binomial distribution
        fitw = fitdist( popCov[ popCov > 0 ], "nbinom", method = 'mle', silent = TRUE )
        #test for unimodality of the depth of coverage
        dip = dip.test( sample (popCov[ popCov > 0 ], 100), simulate.p.value = TRUE, B = 10000 )
        fitVal = c(clName,
                   nbVar,
                   popName[j],
                   fitw$estimate[1],
                   fitw$estimate[2],
                   fitw$loglik,
                   fitw$aic,
                   fitw$bic,
                   dip$p.value)
        clFit = rbind (clFit, fitVal)
        allFit = rbind (allFit, fitVal)
        #plot the observed and theoritical depth of coverage
        pdf( paste( cldir, "pop_", popName[j], ".pdf", sep = "" ), 6, 4 )
        plot(fitw)
        dev.off()
      }
    }
    nbValidPop = length ( allMedPopCov[ allMedPopCov > 0 ] )
    if( nbValidPop >= minPop ){
      nclust = list ( "varID" = as.vector(ClVarName) , "pop" = as.vector( popName[popCol == "orange"] ), "cov" = as.matrix(Cov[ ClVarName, popName[popCol == "orange"] ] ) , "abundance" = as.vector(allMedPopCov))
      varSets[[clName]] = nclust
      write.table(clFit,  paste( cldir, clName, "_NB_fit.txt", sep = ""), sep = "\t", quote = F, row.names = F, col.names = F )
    }
    # plot the coverage distribution
    pdf( paste( cldir, "boxplot_", clName, ".pdf", sep = "" ) , 3.5, 4.5)
    boxplot( Cov[ cl$cluster == i, ], col = popCol, las = 2, ylab = "Depth of coverage for biallelic loci", xlab = "Populations", main = paste( "Cluster_", i, sep = "" ) );
    dev.off()
  }
  write.table(allFit,  paste( pref,"/NB_fit.txt", sep = ""), sep = "\t", quote = F, row.names = F, col.names = F )
  return ( varSets )
}
