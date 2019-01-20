parEstimate<- function (eps, pts, pref, crit = "loglik"){
  outDir = paste(pref, "/parEstimate", sep ="")
  dir.create(outDir, showWarnings = FALSE)
  #combine all metrics for the tested parameters
  Neps = length(eps)
  Npts = length(pts)
  Ncombi = Neps * Npts
  CLS = matrix ( rep(0, 12) , ncol = 12, nrow = 1)
  k = 1
  for (i in eps){
    for (j in pts){
      test = paste( pref,"/", "eps" ,i, "minPts", j, sep="" )
      DirList = list.dirs(test)
      Nclust = length(DirList) - 1
      Nvar = c( seq( 0, Nclust) )
      l = 1
      if (length(DirList) <= 1){
        next
      }
      for (l in 2:length(DirList)){
        cov = read.table(paste(DirList[l],"/cov.txt", sep = "") )
        Nvar[l] = nrow(cov)
      }

      fit = as.matrix(read.table( paste(test, "/NB_fit.txt", sep = ""), header = TRUE ))
      param = matrix (rep(c(i, j, Nclust ),nrow(fit)), nrow = nrow(fit), ncol = 3, byrow = TRUE)
      fit = cbind(param,fit)
      CLS = rbind(CLS,fit)
    }
  }
  CLS = CLS[2:nrow(CLS),]
  CLS = as.data.frame(CLS)
  CLS[,7:12] = sapply(CLS[,7:12], function (x) as.numeric(as.character(x)))
  CLS[,3] = as.numeric(as.character(CLS[,3]))
  CLS[,5] = as.numeric(as.character(CLS[,5]))
  colnames(CLS) = c("eps","pts","nMVS", "Cluster_name", "nVar", "population", "NB_size","NB_mu","NB_loglik","NB_aic","NB_bic","dip_pval")
  write.table(CLS,paste(outDir, "/parameters_fitting_results.txt", sep =""), sep = "\t", quote = FALSE)

  # Plotting all results
  png(paste(outDir,"/MVS_count.png", sep = "") )
  boxplot(nMVS~eps*pts, CLS, xlab = "Parameters couples")
  dev.off()
  png(paste(outDir,"/loglik_distrib.png", sep = "") )
  boxplot(NB_loglik~eps*pts, CLS, xlab = "Parameters couples", ylab = "log-likelihood")
  dev.off()
  png(paste(outDir,"/AIC_distrib.png", sep = "") )
  boxplot(NB_aic~eps*pts, CLS, xlab = "Parameters couples", ylab = "Akaike Information Criterion")
  dev.off()
  png(paste(outDir,"/BIC_distrib.png", sep = "") )
  boxplot(NB_bic~eps*pts, CLS, xlab = "Parameters couples", ylab = "Bayesian Information Criterion")
  dev.off()

  # Calculate the summary statistics (min and median) of the fitting to NB of the depth of coverage for each parameter couple
  ncls = aggregate(data = CLS, nMVS ~ eps * pts, median)
  nVar = aggregate(data = CLS, nVar ~ eps * pts, sum)
  median_Var = aggregate(data = CLS, nVar ~ eps * pts, median)
  median_NB_loglik = aggregate(data = CLS, NB_loglik ~ eps * pts, median)
  min_NB_loglik = aggregate(data = CLS, NB_loglik ~ eps * pts, min)
  median_NB_aic = aggregate(data = CLS, NB_aic ~ eps * pts, median)
  min_NB_aic = aggregate(data = CLS, NB_aic ~ eps * pts, min)
  median_NB_bic = aggregate(data = CLS, NB_bic ~ eps * pts, median)
  min_NB_bic = aggregate(data = CLS, NB_bic ~ eps * pts, min)
  res = cbind(ncls, nVar[,3], median_Var[,3], median_NB_loglik[,3],min_NB_loglik[,3],median_NB_aic[,3], min_NB_aic[,3], median_NB_bic[,3], min_NB_bic[,3])
  colnames(res) = c("eps","pts","nMVS","nVar", "medVar", "medLoglik","minLoglik","medAIC", "minAIC", "medBIC", "minBIC")
  res = sapply(res, function (x) as.numeric(as.character(x)))
  res = as.data.frame(res)
  write.table(res, paste (outDir,"/cov_fitting_summary.txt", sep = ""), sep = "\t", quote = F)
  # estimate the best parameter couple
  if (crit == "loglik"){
    cat ("Estimate the best parameters couple from log-likelihood:\n")

  }
  return(res)
}
