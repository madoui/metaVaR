#' readMvsList
#'
#' read \code{mvs} from a list of directory
#'
#' @param dir a directory.
#' @return a list of \code{mvs}
#'
#' @export
#' @examples
#' \dontshow{
#' # espilon values to test for dbscan
#' e = c(3,5)
#' # minimum points values to test for dbscan
#' p = c(5,10)
#' # sampling 1000 loci from the Mediterranean variant set
#' loci = sample(rownames(MS5$cov), 10000)
#' coverage = MS5$cov[loci,]
#'
#' # MVC and MVS creation
#' MVC = tryParam (e, p, coverage)
#' MWIS = getMWIS (MVC)
#' frequencies = MS5$freq[loci,]
#' MVS = mvc2mvs(MWIS, freq = frequencies)
#'
#' # store and read MVC
#' writeMvcList(MVC, "MVC")
#' MVC2 = readMvcList("MVC")
#'
#' # store and read MVS
#' writeMvsList(MVS, "MVS")
#' MVS2 = readMvsList("MVS")
#' unlink("MVC")
#' unlink("MVS")
#'
#' }
readMvsList<-function(dir = "") {
  readMvs <- function(mvsDir){
    print (paste("Reading directory: ", mvsDir, "\n", sep = ""))
    covFile = paste (mvsDir,"/coverage.txt", sep = "")
    mvsCov = read.table(covFile, header = TRUE, row.names = 1)
    mvsVar = rownames(mvsCov)
    mvsPop = colnames(mvsCov)
    freqFile = paste (mvsDir,"/frequencies.txt", sep = "")
    mvsFreq = read.table(freqFile, header = TRUE, row.names = 1)
    pwFstFile = paste (mvsDir,"/pwFst.txt", sep = "")
    mvsPwfst = read.table(pwFstFile, header = TRUE, row.names = 1)
    gFstFile = paste (mvsDir,"/gFst.txt", sep = "")
    mvsGfst = read.table(gFstFile, header = FALSE)
    mvsGfst = mvsGfst$V1
    gLKFile = paste (mvsDir,"/gLK.txt", sep = "")
    mvsGLK = read.table(gLKFile, header = FALSE)
    mvsGLK = mvsGLK$V1
    mvsInfo = gsub(pattern = ".*/","",mvsDir)
    mvsName = mvsInfo[[1]][1]
    mvsInfo = strsplit(mvsInfo, "_")
    fitFile = paste (mvsDir,"/loglik.txt", sep = "")
    fit = read.table(fitFile, header = TRUE)
    fitList = list()
    for (i in 1:nrow(fit)){
      pop = as.character(fit[i,1])
      loglik = fit[i,2]
      fitList[[pop]] = list("loglik" = loglik )
    }
    mwisFile = paste (mvsDir,"/mwis.txt", sep = "")
    mwis = read.table(mwisFile, header = TRUE)
    mvsComp = as.numeric(as.character(mwis[1,2]))
    mvsDegree = as.numeric(as.character(mwis[2,2]))
    mvsWeight = as.numeric(as.character(mwis[3,2]))
    mvsSore = as.numeric(as.character(mwis[4,2]))
    mvsMwis = as.numeric(as.character(mwis[5,2]))
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
               gLK = as.data.frame(mvsGLK))
    return(mvs)
  }

  MVS = list()
  list.dirs <- function(parent=".")   # recursively find directories
  {
    if (length(parent)>1)           # work on first and then rest
      return(c(list.dirs(parent[1]), list.dirs(parent[-1])))
    else {                          # length(parent) == 1
      if (!is.dir(parent))
        return(NULL)            # not a directory, don't return anything
      child <- list.files(parent, full.names = TRUE)
      if (!any(is.dir(child)))
        return(parent)          # no directories below, return parent
      else
        return(list.dirs(child))    # recurse
    }
  }

  is.dir <- function(x)    # helper function
  {
    ret <- file.info(x)$isdir
    ret[is.na(ret)] <- FALSE
    ret
  }
  mvsDirList = list.dirs(dir)
  for (mvsDir in mvsDirList){
    mvs = readMvs (mvsDir = mvsDir)
    MVS[[mvs@name]] = mvs
  }
  return (MVS)
}
