#' readMvcList
#'
#' read \code{mvc} from a list of directory
#'
#' @param dir a directory.
#' @return a list of \code{mvc}
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
readMvcList<-function(dir = "") {
  readMvc <- function(mvcDir){
    cat (paste("Reading directory: ", mvcDir, "\n",sep =""))
    covFile = paste (mvcDir,"/coverage.txt", sep = "")
    mvcCov = read.table(covFile, header = TRUE, row.names = 1)
    mvcVar = rownames(mvcCov)
    mvcPop = colnames(mvcCov)
    mvcInfo = gsub(pattern = ".*/","",mvcDir)
    mvcName = mvcInfo[[1]][1]
    mvcInfo = strsplit(mvcInfo, "_")
    fitFile = paste (mvcDir,"/loglik.txt", sep = "")
    fit = read.table(fitFile, header = TRUE)
    fitList = list()
    for (i in 1:nrow(fit)){
      pop = as.character(fit[i,1])
      loglik = fit[i,2]
      fitList[[pop]] = list("loglik" = loglik )
    }
    mwisFile = paste (mvcDir,"/mwis.txt", sep = "")
    mwis = read.table(mwisFile, header = TRUE)
    mvcComp = as.numeric(as.character(mwis[1,2]))
    mvcDegree = as.numeric(as.character(mwis[2,2]))
    mvcWeight = as.numeric(as.character(mwis[3,2]))
    mvcSore = as.numeric(as.character(mwis[4,2]))
    mvcMwis = as.numeric(as.character(mwis[5,2]))
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
  MVC = list()
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
  mvcDirList = list.dirs(dir)
  for (mvcDir in mvcDirList){
    mvc = readMvc (mvcDir = mvcDir)
    MVC[[mvc@name]] = mvc
  }
  return (MVC)
}
