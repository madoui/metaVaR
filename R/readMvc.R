#' readMvc
#'
#' Read a \code{mvc} from a directory dreated by \code{writeMvc}
#'
#' @param mvcDir output directory
#' @return an object of class \code{mvc}
#' @export
readMvc <- function(mvcDir){
  cat (paste("Reading directory: ", mvcDir, "\n",sep =""))
  covFile = paste (mvcDir,"/coverage.txt", sep = "")
  mvcCov = read.table(covFile, header = T, row.names = 1)
  mvcVar = rownames(mvcCov)
  mvcPop = colnames(mvcCov)
  mvcInfo = gsub(pattern = ".*/","",mvcDir)
  mvcName = mvcInfo[[1]][1]
  mvcInfo = strsplit(mvcInfo, "_")
  fitFile = paste (mvcDir,"/loglik.txt", sep = "")
  fit = read.table(fitFile, header = T)
  fitList = list()
  for (i in 1:nrow(fit)){
    pop = as.character(fit[i,1])
    loglik = fit[i,2]
    fitList[[pop]] = list("loglik" = loglik )
  }
  mwisFile = paste (mvcDir,"/mwis.txt", sep = "")
  mwis = read.table(mwisFile, header = T)
  mvcComp = mwis[1,2]
  mvcDegree = mwis[2,2]
  mvcWeight = mwis[3,2]
  mvcSore = mwis[4,2]
  mvcMwis = mwis[5,2]
  mvc = mvc (name = mvcName,
             eps = as.numeric(mvcInfo[[1]][1]),
             pts = as.numeric(mvcInfo[[1]][2]),
             cov = mvcCov,
             pop = mvcPop,
             var = mvcVar,
             fit = fitList,
             comp = mvcComp,
             deg = mvcDegree,
             weight = mvcWeight,
             score = mvcSore,
             mwis = as.logical(mvcMwis))
  return(mvc)
}
