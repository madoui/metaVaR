#' Maximum Weighted Indepedent Set
#'
#' Calculate the mvc weight and score in a list of object of class \code{mvc}.
#' Identify some the maximum weighted independant sets and update the mwis slot
#'
#' @param MVC a list of object of class \code{mvc}.
#' @param nbComp number of connected components
#' @return a list of object of class \code{mvc}.
#' @export
mwis<-function(nbComp, MVC){
  for (i in 1:nbComp){
    mvcList = list()
    for (mvc in MVC){
      if (mvc@comp == i){
        mvcList[[mvc@name]] = mvc
      }
    }
    loglik = matrix(rep(0,length(mvcList)*length(mvc@pop)),
                    ncol = length(mvcList),
                    nrow = length(mvc@pop),
                    dimnames = list(mvc@pop,names(mvcList)))
    mvcSize = c(rep(0,length(mvcList)))
    names(mvcSize) = names(mvcList)
    # get loglikelihoods for connected mvc
    for (mvc in mvcList){
      mvcSize[mvc@name] = length (mvc@var)
      for (pop in names(mvc@fit)){
        loglik[pop,mvc@name] = mvc@fit[[pop]]$loglik
      }
    }
    # calculate mvc weight, weight = mean of normalized loglikelihood by connected mvc to get mvc weight
    maxL = max(loglik)
    minL = min(loglik)
    loglik = (loglik - minL)/(maxL - minL)
    l = colMeans(loglik)
    maxS = max(mvcSize)
    minS = min(mvcSize)
    s = (mvcSize - minS)/(maxS-minS)

    # calculate the mvc score, mvc score = mvc weight / (mvc degree + 1)
    maxScore = 0
    for (mvc in mvcList){
      mvcName = mvc@name
      mvcWeight = sqrt(l[mvcName]*s[mvcName])
      mvcdegree = mvc@deg
      mvcScore = mvcWeight/ (mvcdegree + 1)
      mvc = setMvc(mvc, weight = mvcWeight, score = mvcScore)
      MVC[[mvcName]] = mvc
      if (maxScore < mvcScore){
        maxScore = mvcScore
        mwis = mvcName
      }
    }
    message (paste("MWIS mvc: ",mwis,"\n", sep =""))
    MVC[[mwis]] = setMvc(MVC[[mwis]], mwis = TRUE)

  }
  return (MVC)
}
