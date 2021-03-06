#' mvc2mvs
#'
#' mvc2mvs selects the \code{mvc} being maximum weighted independent
#' set and passing quality filters to generates the \code{mvs}.
#'
#' @param MVC a list of object of class \code{mvc}.
#' @param minCov minimum median depth of coverage, set to 8 by default.
#' @param minPop minimum number of population with \code{minCov}, set to 3 by default.
#' @param minVar minimum number of variants in a \code{mvs}, set to 100 by default.
#' @param freq allele frequencies in a \code{data.frame}
#' @param minVarCov minimum depth of coverage of loci, set to 8 by default.
#' @param sd standard deviation of depth of coverage to select variant, set to 2 by default.
#' @return a list of objects of class \code{mvs}.
#' @examples
#' \dontrun{
#' e = c(5,6)
#' p = c(5, 10)
#' MVC = tryParam(e, p , MS5$cov)
#' MWIS = getMWIS (MVC)
#' MVS = mvc2mvs (MWIS, freq = MS5$freq, minPop = 3, minCov = 6 , minVarCov = 8, sd = 2, minVar = 100)}
#' @export
#'
mvc2mvs <- function (MVC, minPop = 3, minCov = 8 , freq , minVarCov = 8, sd = 2, minVar = 100){
  MVS = list()
  for (mvc in MVC){
    if(mvc@mwis == FALSE ){
      next
    }
    mvs = as(mvc, "mvs")
    mvsName = mvs@name
    mvsPop = mvs@pop
    mvsCov = mvs@cov
    popStatus = apply (mvsCov, 2, function (x) if (median (x) >= minCov){TRUE}else{FALSE})
    mvsPop = mvsPop[popStatus == TRUE]
    if (length(mvsPop) < minPop){
      next
    }
    mvsCov = varFilterbyCov( mvsCov[,mvsPop] , minCov = minVarCov, dev = sd)
    if (nrow(mvsCov) < minVar){
      next
    }
    else{
      cat (paste("mvc",mvsName,"is a valid mvs\n", sep = " "))
      mvsVar = rownames(mvsCov)
      mvsFreq = freq[mvsVar,mvsPop]
      mvsFst = fst(mvsFreq)
      mvsPwFst = pwFst(mvsFreq)
      mvsLK = LK (mvsFreq)
      mvs = as(mvc,"mvs")
      MVS[[mvsName]] = setMvs (mvs,
                               cov = mvsCov,
                               pop = mvsPop,
                               var = mvsVar,
                               freq = mvsFreq,
                               gFst = mvsFst,
                               pwFst = mvsPwFst,
                               gLK = mvsLK)
    }

  }
  return(MVS)
}
