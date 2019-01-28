#' mvs
#' @param id mvs id
#' @param freq allele frequency
#' @param gFst global Fst
#' @param gLK global LK
#' @param pwFst pairwise-Fst
#' @inheritParams mvc
#' @include mvs_class.R
#' @export
mvs <- function (id = "",
                 freq = data.frame(),
                 gFst = 0,
                 gLK = 0,
                 pwFst = data.frame(),
                 name = "",
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
                 mwis = FALSE
                ){
  new (Class = "mvs",
       id = id,
       freq = freq,
       gFst = gFst,
       gLK = gLK,
       pwFst = pwFst,
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
       mwis = mwis
       )
}
