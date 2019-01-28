#' writeMvcList
#'
#' Write a list of \code{mvc} in an output directory
#'
#' @param MVC a list of objects of class \code{mvc}.
#' @param prefix output directory
#'
#' @export

writeMvcList<-function(MVC, prefix = "out") {
  for (mvc in MVC){
    writeMvc(mvc, prefix)
  }
}
