#' Reading a MVC from a file
#'
#' Read a \code{mvc} from a directory dreated by \code{writeMvc}
#'
#' @param mvcDir output directory
#' @return an object of class \code{mvc}
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
#' # Testing dbscan parameters
#' MVC = tryParam (e, p, coverage)
#'
#' # write MVC
#' writeMvcList (MVC, "output_dir")
#'
#' # Read MVC
#' MVC_list = readMvcList ("output_dir")
#' unlink("output_dir")
#'
#' }
#' \donttest{
#' # espilon values to test for dbscan
#' e = c(3,5)
#' # minimum points values to test for dbscan
#' p = c(5,10)
#'
#' # Testing dbscan parameters
#' MVC = tryParam (e, p, MS5$cov)
#'
#' # write MVC
#' writeMvcList (MVC, "output_dir")
#'
#' # Read MVC
#' MVC_list = readMvcList ("output_dir")
#' }

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
