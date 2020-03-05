#' Adjacency matrix of metavariant clusters
#'
#' Build an adjacency matrix of a mvc based on shared metavariants between multiple object of class \code{mvc}
#'
#' @param MVC a list of objects of class \code{mvc}.
#' @return a mvc adjacency matrix of class \code{matrix}.
#' @export
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
#' AdjMat = mvc2AdjMat(MVC)
#' }
#' \donttest{
#' # espilon values to test for dbscan
#' e = c(3,5)
#' # minimum points values to test for dbscan
#' p = c(5,10)
#' # Testing dbscan parameters
#' MVC = tryParam (e, p, MS5$cov)
#' AdjMat = mvc2AdjMat(MVC)
#' }
mvc2AdjMat <- function(MVC){
  #check input parameter MVC
  if( !all( lapply (MVC, class) == "mvc" ) ){
      error = "MVC parameter provided is not a list of mvc objects\n"
      warning(error)
      return (error)
  }
  #create a squared matrix with 0
  mvcNames = names(MVC)
  mvcNb = length(MVC)
  mvcAdjMat = matrix(rep(0,mvcNb^2),
                     ncol = mvcNb,
                     nrow = mvcNb,
                     dimnames = list(mvcNames,mvcNames)
  )
  #add the number of metavariants in shared by two mvcs
  for (mvc1 in MVC){
    var1 = mvc1@var
    for (mvc2 in MVC){
      var2 = mvc2@var
      sharedVar = length(intersect(var1,var2))
      mvcAdjMat[mvc1@name, mvc2@name] = sharedVar
    }
  }
  return (mvcAdjMat)
}
#' MVC graph
#'
#' Create an undirected graph from an adjacency matrix of mvc
#'
#' @param adjMatrix an adjacency matrix of class \code{matrix}.
#' @return a graph object of class \code{igraph}.
#' @importFrom igraph graph_from_adjacency_matrix
#' @importFrom igraph simplify
#' @export
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
#' AdjMat = mvc2AdjMat(MVC)
#' graph = AdjMat2Graph(AdjMat)
#' }
#' \donttest{
#' # espilon values to test for dbscan
#' e = c(3,5)
#' # minimum points values to test for dbscan
#' p = c(5,10)
#' # Testing dbscan parameters
#' MVC = tryParam (e, p, MS5$cov)
#' AdjMat = mvc2AdjMat(MVC)
#' graph = AdjMat2Graph(AdjMat)
#' }
AdjMat2Graph <- function (adjMatrix){
  # check input parameter adjMatrix
  if (!isSymmetric.matrix(adjMatrix)){
    error = "adjMatrix is not a symetric matrix\n"
    warning(error)
    return (error)
  }
  mvcGraph = graph_from_adjacency_matrix(adjMatrix, mode = "upper")
  mvcGraph = simplify(mvcGraph)
  return (mvcGraph)
}
#' Graph to metavariant cluster connected components
#'
#' Extract connected components from the mvc graph and attribute the mvc to components
#'
#' @param graph an adjacency matrix.
#' @param mvcList a list of object of class \code{mvc}.
#' @return a list of object of class \code{mvc} assigned to graph component.
#' @importFrom igraph components
#' @importFrom igraph degree
#' @export
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
#' AdjMat = mvc2AdjMat(MVC)
#' graph = AdjMat2Graph(AdjMat)
#' ConneComp = graph2mvcComp (graph,MVC)
#' }
#' \donttest{
#' # espilon values to test for dbscan
#' e = c(3,5)
#' # minimum points values to test for dbscan
#' p = c(5,10)
#' # Testing dbscan parameters
#' MVC = tryParam (e, p, MS5$cov)
#' AdjMat = mvc2AdjMat(MVC)
#' graph = AdjMat2Graph(AdjMat)
#' ConneComp = graph2mvcComp (graph,MVC)
#' }
graph2mvcComp <- function (graph,mvcList){
  # check input parameter adjMatrix
  if (!class(graph)=="igraph" || !all(lapply(mvcList,class)=="mvc")){
    error = "graph is not an object of class igraph \n
                or mvcList parameter provided is not a list of mvc objects\n"
    warning(error)
    return (error)
  }
  mvcComp = components(graph)$membership
  mvcDegree = degree(graph)
  for(mvc in mvcList){
    mvc = setMvc(mvc, comp = mvcComp[mvc@name], deg = mvcDegree[mvc@name])
    mvcList[[mvc@name]] = mvc
  }
  message (paste (max(mvcComp), "components found\n", sep =" "))
  return (mvcList)
}
#' Metavariant clusters to graph
#'
#' Create an undirected graph of a list of \code{mvc}
#'
#' @param mvcList a list of object of class \code{mvc}.
#' @return a mvc graph of class \code{igraph}.
#' @export
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
#' graph = mvc2graph(MVC)
#' }
#' \donttest{
#' # espilon values to test for dbscan
#' e = c(3,5)
#' # minimum points values to test for dbscan
#' p = c(5,10)
#' # Testing dbscan parameters
#' MVC = tryParam (e, p, MS5$cov)
#' graph = mvc2graph(MVC)
#' }
mvc2graph <- function (mvcList){
  #check input parameter mvcList
  if(!all(lapply(mvcList,class)=="mvc")){
    error = "mvcList parameter provided is not a list of mvc objects\n"
    warning(error)
    return (error)
  }
  return (AdjMat2Graph(mvc2AdjMat(mvcList)))
}
