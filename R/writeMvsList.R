#' writeMvsList
#'
#' Write a list of \code{mvs} in an output directory
#'
#' @param MVS a list of objects of class \code{mvs}.
#' @param prefix output directory
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
#' # store MVC
#' writeMvcList(MVC, "MVC")
#'
#' # store MVS
#' writeMvsList(MVS, "MVS")
#'
#' unlink("MVS")
#' unlink("MVC")
#'
#' }
#' \donttest{
#' # espilon values to test for dbscan
#' e = c(3,5)
#' # minimum points values to test for dbscan
#' p = c(5,10)
#'
#' # MVC and MVS creation
#' MVC = tryParam (e, p, MS5$cov)
#' MWIS = getMWIS (MVC)
#' MVS = mvc2mvs(MWIS, freq = MS5$freq)
#'
#' # Pairwie-FST
#' pwFst(MVS[[1]]@freq)
#' plotMvs(MVS[[1]], type = "heatFst")
#'
#' # store MVC
#' writeMvcList(MVC, "output")
#'
#' # store MVS
#' writeMvsList(MVS, "output")
#'
#' }
writeMvsList<-function(MVS, prefix = "../out") {
  for (mvs in MVS){
    writeMvs(mvs, prefix)
  }
}
