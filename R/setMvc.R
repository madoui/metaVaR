#' setMvc
#'
#' set \code{mvc} attributes
#'
#' @param x an object of class \code{mvc}.
#' @param name cluster name.
#' @param eps epsilon value used by dbscan.
#' @param pts minimum points value used by dbscan.
#' @param var metavariants IDs.
#' @param pop population names.
#' @param cov depth of coverage matrix of biallelic loci.
#' @param fit \code{fitdist} object for fitting between observed and theoritical depth of coverage.
#' @param comp component id of the mvc.
#' @param deg mvc degree in the mvc graph
#' @param weight mvc weight
#' @param score mvc score for maximum weighted independant set
#' @param mwis logical, if true the mvc is a maximum weighted independant set
#' @return an object of class \code{mvc}.
#'
#' @docType methods
#' @name  setMvc
#' @rdname setMvc-methods
#' @exportMethod setMvc
#' @include mvc_class.R

setGeneric(
  name = "setMvc",
  def = function(x,
                 name = x@name,
                 eps = x@eps,
                 pts = x@pts,
                 var = x@var,
                 pop = x@pop,
                 cov = x@cov,
                 fit = x@fit,
                 comp = x@comp,
                 deg = x@deg,
                 weight = x@weight,
                 score = x@score,
                 mwis = x@mwis){
    standardGeneric("setMvc")
  }
)
#' @rdname setMvc-methods
#' @aliases setMvc,mvc-method
setMethod(
  f = "setMvc",
  signature = "mvc",
  definition = function(x,
                        name = x@name,
                        eps = x@eps,
                        pts = x@pts,
                        var = x@var,
                        pop = x@pop,
                        cov = x@cov,
                        fit = x@fit,
                        comp = x@comp,
                        deg = x@deg,
                        weight = x@weight,
                        score = x@score,
                        mwis = x@mwis){
    if(is.null(x) || class(x)!="mvc"){
      error = cat ("x must be an object of class mvc\n")
      return (error)
    }
    x@name = name
    x@eps = eps
    x@pts = pts
    x@var = var
    x@pop = pop
    x@cov = cov
    x@fit = fit
    x@comp = comp
    x@deg = deg
    x@weight = weight
    x@score = score
    x@mwis = mwis
    return (x)
  }
)
