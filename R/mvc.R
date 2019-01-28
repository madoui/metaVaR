#' mvc
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
#' @param mwis logical, set to true if the mvc is a maximum weighted independant set
#' @include mvc_class.R
#' @import methods
#' @import utils
#' @import graphics
#' @import grDevices
#' @import stats
#' @import MASS
#' @import survival
#' @export
mvc <- function (name = "",
                 eps = 0,
                 pts = 0,
                 var = c(),
                 pop = c(),
                 cov = data.frame(),
                 fit = list(),
                 comp = 0,
                 deg = 0,
                 weight = 0,
                 score = 0,
                 mwis = FALSE){
  new (Class = "mvc",
       name = name,
       eps = eps,
       pts = pts,
       var = var,
       pop = pop,
       cov = cov,
       fit = fit,
       comp = comp,
       deg = deg,
       weight = weight,
       score = score,
       mwis = mwis)
}
