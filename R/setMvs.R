#' setMvs
#'
#' set \code{mvs} attributes
#'
#' @param mvs an object of class \code{mvs}.
#' @param id mvs name.
#' @param freq allele frequencies
#' @param gFst global Fst
#' @param gLK global LK
#' @param pwFst pairwise-Fst
#' @inheritParams setMvc
#' @return an object of class \code{mvs}.
#'
#' @docType methods
#' @name  setMvs
#' @rdname setMvs-methods
#' @exportMethod setMvs
#' @include mvs_class.R

setGeneric(
  name = "setMvs",
  def = function(x,
                 id = x@id,
                 freq = x@freq,
                 gFst = x@gFst,
                 gLK = x@gLK,
                 pwFst = x@pwFst,
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
    standardGeneric("setMvs")
  }
)
#' @rdname setMvs-methods
#' @aliases setMvs,mvs-method
setMethod(
  f = "setMvs",
  signature = "mvs",
  definition = function(x,
                        id = x@id,
                        freq = x@freq,
                        gFst = x@gFst,
                        gLK = x@gLK,
                        pwFst = x@pwFst,
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
    if(is.null(x) || class(x)!="mvs"){
      error = cat ("x must be an object of class mvs\n")
      return (error)
    }
    x@id = id
    x@freq = freq
    x@gFst = gFst
    x@gLK = gLK
    x@pwFst = pwFst
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
