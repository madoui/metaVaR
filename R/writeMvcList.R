#' write a Mvc list
#'
#' writeMvcList Writes a list of object of class \code{mvc} in at directory
#'
#' @param MVC a list of objects of class \code{mvc}.
#' @param prefix output directory (default is out)
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
#' unlink("MVC")
#' unlink("MVS")
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
#' writeMvcList(MVC, "MVC")
#'
#' # store MVS
#' writeMvsList(MVS, "MVS")
#'
#' }
writeMvcList<-function(MVC, prefix = "../out") {
  for (mvc in MVC){
    writeMvc(mvc, prefix)
  }
}
