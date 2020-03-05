#' getMWIS
#'
#' getMWIS identifies all the maximum weighted independant sets from a list of \code{mvc}.
#'
#' @param MVC a list of objects of class \code{mvc}.
#' @param p \code{logical}, for graphical output, set to TRUE by default.
#' @param prefix name of the graphical output directory, set to "out" by default.
#' @return a list of object of class \code{mvc} candidate for \code{mvs}.
#' @importFrom igraph neighbors
#' @importFrom igraph as_ids
#' @references S. Sakai, M. Togasaki, K. Yamazaki. A note on greedy algorithms
#' for the maximum weighted independent set problem. \emph{Discrete applied Mathematics
#' }, 126:313-322, 2003.
#' @examples
#' \dontshow{
#' # espilon values to test for dbscan
#' e = c(3,5)
#' # minimum points values to test for dbscan
#' p = c(5,10)
#' # sampling 1000 loci from the Mediterranean variant set
#' loci = sample(rownames(MS5$cov), 10000)
#' coverage = MS5$cov[loci,]
#' # Testing dbscan parameters
#' MVC = tryParam (e, p, coverage)
#' MWIS = getMWIS (MVC)
#' frequencies = MS5$freq[loci,]
#' MVS = mvc2mvs(MWIS, freq = frequencies)
#' plotMvs(MVS[[1]], type = "heatFst")
#' }
#' \donttest{
#' # espilon values to test for dbscan
#' e = c(3,5)
#' # minimum points values to test for dbscan
#' p = c(5,10)
#' # Testing dbscan parameters
#' MVC = tryParam (e, p, MS5$cov)
#' MWIS = getMWIS (MVC)
#' MVS = mvc2mvs(MWIS, freq = MS5$freq)
#' plotMvs(MVS[[1]], type = "heatFst")
#' }
#' @export

getMWIS<-function(MVC, p = FALSE, prefix = "out"){
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

  MWIS = list()
  if (p == TRUE && !dir.exists(prefix)){
    dir.create(prefix, showWarnings = FALSE)
  }
  # while there is still mvc(s) in the mvc list (MVC)
  while (length(MVC)>0){
    # built an undirected graph from the mvs list
    mvcGraph = mvc2graph(MVC)
    mvcCol = rep ("white", length(MVC))
    names (mvcCol) = names(MVC)
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
        mvcCol[mvc@name] = "green"
        MWIS[[mvc@name]] = mvc
        MVC[[mvc@name]] = NULL
        # identify the neighbors of the mvs
        adjMvc = neighbors(mvcGraph, mvc@name)
        for (i in as_ids(adjMvc)){
          # remove the neighbors from the list MVC
          MVC[[i]] = NULL
          mvcCol[i] = "red"
        }
      }
    }
    if ( p == TRUE){
      graphFile = paste(prefix,"/MVC_graph_",length(MVC),"_nodes.png", sep = "")
      png(graphFile)
      plot(mvcGraph, vertex.color = mvcCol,  vertex.color= mvcCol)
      dev.off()
    }
  }
  return(MWIS)
}
