#' write a Mvc list
#'
#' writeMvcList Writes a list of object of class \code{mvc} in at directory
#'
#' @param MVC a list of objects of class \code{mvc}.
#' @param prefix output directory (default is out)
#'
#' @export

writeMvcList<-function(MVC, prefix = "out") {
  for (mvc in MVC){
    writeMvc(mvc, prefix)
  }
}
