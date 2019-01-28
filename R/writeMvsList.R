#' writeMvsList
#'
#' Write a list of \code{mvs} in an output directory
#'
#' @param MVS a list of objects of class \code{mvs}.
#' @param prefix output directory
#'
#' @export

writeMvsList<-function(MVS, prefix = "out") {
  for (mvs in MVS){
    writeMvs(mvs, prefix)
  }
}
