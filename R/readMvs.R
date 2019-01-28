#' readMvs
#'
#' Read a \code{mvs} from a directory dreated by \code{writeMvs}
#'
#' @param mvsDir output directory
#' @return an object of class \code{mvs}
#' @export
readMvs <- function(mvsDir){
  cat (paste("Reading directory: ", mvsDir, "\n", sep = ""))
  covFile = paste (mvsDir,"/coverage.txt", sep = "")
  mvsCov = read.table(covFile, header = T, row.names = 1)
  mvsVar = rownames(mvsCov)
  mvsPop = colnames(mvsCov)
  freqFile = paste (mvsDir,"/frequencies.txt", sep = "")
  mvsFreq = read.table(freqFile, header = T, row.names = 1)
  pwFstFile = paste (mvsDir,"/pwFst.txt", sep = "")
  mvsPwfst = read.table(pwFstFile, header = T, row.names = 1)
  gFstFile = paste (mvsDir,"/gFst.txt", sep = "")
  mvsGfst = read.table(gFstFile, header = F)
  mvsGfst = mvsGfst$V1
  gLKFile = paste (mvsDir,"/gLK.txt", sep = "")
  mvsGLK = read.table(gLKFile, header = F)
  mvsGLK = mvsGLK$V1
  mvsInfo = gsub(pattern = ".*/","",mvsDir)
  mvsName = mvsInfo[[1]][1]
  mvsInfo = strsplit(mvsInfo, "_")
  fitFile = paste (mvsDir,"/loglik.txt", sep = "")
  fit = read.table(fitFile, header = T)
  fitList = list()
  for (i in 1:nrow(fit)){
    pop = as.character(fit[i,1])
    loglik = fit[i,2]
    fitList[[pop]] = list("loglik" = loglik )
  }
  mwisFile = paste (mvsDir,"/mwis.txt", sep = "")
  mwis = read.table(mwisFile, header = T)
  mvsComp = mwis[1,2]
  mvsDegree = mwis[2,2]
  mvsWeight = mwis[3,2]
  mvsSore = mwis[4,2]
  mvsMwis = mwis[5,2]
  mvs = mvs (name = mvsName,
             eps = as.numeric(mvsInfo[[1]][1]),
             pts = as.numeric(mvsInfo[[1]][2]),
             cov = mvsCov,
             pop = mvsPop,
             var = mvsVar,
             fit = fitList,
             comp = mvsComp,
             deg = mvsDegree,
             weight = mvsWeight,
             score = mvsSore,
             mwis = as.logical(mvsMwis),
             freq = mvsFreq,
             pwFst = mvsPwfst,
             gFst = mvsGfst,
             gLK = mvsGLK)
  return(mvs)
}
