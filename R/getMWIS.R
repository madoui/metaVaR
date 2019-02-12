#' getMWIS
#'
#' getMWIS identifies all the maximum weighted independant sets from a list of \code{mvc}.
#'
#' @param MVC a list of objects of class \code{mvc}.
#' @return a list of object of class \code{mvc} candidate for \code{mvs}.
#' @importFrom igraph neighbors
#' @importFrom igraph as_ids
#' @references S. Sakai, M. Togasaki, K. Yamazaki. A note on greedy algorithms
#' for the maximum weighted independent set problem. \emph{Discrete applied Mathematics
#' }, 126:313-322, 2003.
#' @examples
#' data("MS5")
#' e = c(3,5)
#' p = c(5, 10)
#' MVC = tryParam(e, p , MS5$cov)
#' MWIS = getMWIS (MVC)
#' @export

getMWIS<-function(MVC){
  MWIS = list()
  # while there is still mvc(s) in the mvc list (MVC)
  while (length(MVC)>0){
    # built an undirected graph from the mvs list
    mvcGraph = mvc2graph(MVC)
    # assign mvcs to connected components
    MVC = graph2mvcComp (mvcGraph, MVC)
    # get the number of connected components
    nbComp = max(as.data.frame(lapply(MVC, function (x) x@comp)))
    cat (paste(nbComp, " connected components\n", sep = ""))
    # identify mwis in the mvc list MVC
    MVC = mwis (nbComp, MVC)
    for (mvc in MVC){
      # if the mvs is a mwis, remove it from the list and store it in another list (MWIS)
      if (mvc@mwis == TRUE){
        MWIS[[mvc@name]] = mvc
        MVC[[mvc@name]] = NULL
        # identify the neighbors of the mvs
        adjMvc = neighbors(mvcGraph, mvc@name)
        for (i in as_ids(adjMvc)){
          # remove the neighbors from the list MVC
          MVC[[i]] = NULL
        }
      }
    }
  }
  return(MWIS)
}
