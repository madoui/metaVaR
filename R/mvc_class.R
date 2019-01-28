#' Class mvc
#'
#' Class \code{mvc} defines a metavariants cluster.
#'
#' @section Slots:
#' \describe{
#'    \item{name}{cluster name.}
#'    \item{eps}{epsilon value used by dbscan.}
#'    \item{pts}{minimum points value used by dbscan.}
#'    \item{var}{metavariants IDs.}
#'    \item{pop}{population names.}
#'    \item{cov}{depth of coverage matrix of biallelic loci.}
#'    \item{fit}{\code{fitdist} objects for fitting between observed and theoritical depth of coverage in each population.}
#'    \item{comp}{component id of the mvc.}
#'    \item{deg}{mvc degree in mvc graph.}
#'    \item{weight}{mvc weight.}
#'    \item{score}{mvc score for maximum weighted independant set}
#'    \item{mwis}{logical, if true the mvc is a maximum weighted independant set}
#'  }
#' @name mvc-class
#' @rdname mvc-class
#' @exportClass mvc
#' @author momosapiens
setClass(Class = "mvc",
         representation = representation(name = "character",
                        eps = "numeric",
                        pts = "numeric",
                        var = "character",
                        pop = "character",
                        cov = "data.frame",
                        fit = "list",
                        comp = "numeric",
                        deg = "numeric",
                        weight = "numeric",
                        score = "numeric",
                        mwis = "logical"),
         prototype = list(
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
           mwis = FALSE),


         validity=function(object)
         {
           if (is.na(object@name)){
             return (TRUE)
           }
           if( length(object@var) != nrow(object@cov ) ){
             return ( "Number of variant not coherent to coverage data" )
           }
           if( !all( object@pop == colnames(object@cov) ) ) {
             return ( "Population names not coherent to coverage data" )
           }
           if ( any( is.na( object@cov ) ) ){
             return( "Coverage data contains NA" )
           }
           return(TRUE)
         }

)
