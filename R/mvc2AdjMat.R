#' mvc2AdjMat
#'
#' Create an adjacency matrix mvc based on shared metavariants between \code{mvc}
#'
#' @param MVC a list of objects of class \code{mvc}.
#' @return a mvc adjacency matrix.
#' @export

mvc2AdjMat <- function(MVC){
  #check input parameter MVC
  if( !all( lapply (MVC, class) == "mvc" ) ){
      error = cat( "MVC parameter provided is not a list of mvc objects\n")
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
#' AdjMat2Graph
#'
#' Create an undirected graph from an adjacency matrix of mvc
#'
#' @param adjMatrix an adjacency matrix.
#' @return a graph object of class \code{igraph}.
#' @importFrom igraph graph_from_adjacency_matrix
#' @importFrom igraph simplify
#' @export
AdjMat2Graph <- function (adjMatrix){
  # check input parameter adjMatrix
  if (!isSymmetric.matrix(adjMatrix)){
    error = cat("adjMatrix is not a symetric matrix\n")
    return (error)
  }
  mvcGraph = graph_from_adjacency_matrix(adjMatrix, mode = "upper")
  mvcGraph = simplify(mvcGraph)
  return (mvcGraph)
}
#' graph2mvcComp
#'
#' Extract connected mvs from the mvc graph and attribute the mvc to components
#'
#' @param graph an adjacency matrix.
#' @param mvcList a list of object of class \code{mvc}.
#' @return a list of object of class \code{mvc} assigned to graph component.
#' @importFrom igraph components
#' @importFrom igraph degree
#' @export
graph2mvcComp <- function (graph,mvcList){
  # check input parameter adjMatrix
  if (!class(graph)=="igraph" || !all(lapply(mvcList,class)=="mvc")){
    error = cat("graph is not an object of class igraph \n
                or mvcList parameter provided is not a list of mvc objects\n")
    return (error)
  }
  mvcComp = components(graph)$membership
  mvcDegree = degree(graph)
  for(mvc in mvcList){
    mvc = setMvc(mvc, comp = mvcComp[mvc@name], deg = mvcDegree[mvc@name])
    mvcList[[mvc@name]] = mvc
  }
  cat (paste (max(mvcComp), " components found\n", sep =""))
  return (mvcList)
}
#' mvc2graph
#'
#' Create an undirected graph of a list of \code{mvc}
#'
#' @param mvcList a list of object of class \code{mvc}.
#' @return a mvc graph of class \code{igraph}.
#' @export
mvc2graph <- function (mvcList){
  #check input parameter mvcList
  if(!all(lapply(mvcList,class)=="mvc")){
    error = cat( "mvcList parameter provided is not a list of mvc objects\n")
    return (error)
  }
  return (AdjMat2Graph(mvc2AdjMat(mvcList)))
}
