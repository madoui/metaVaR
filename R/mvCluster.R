#' mvCluster object
#'
#' metavariants cluster
#'
#' @section Slots:
#' \describe{
#'    \item{name}{cluster name.}
#'    \item{eps}{epsilon value used by dbscan.}
#'    \item{pts}{minimum points value used by dbscan.}
#'    \item{nvar}{number of metavariants}
#'    \item{pop}{population names where the cluster occurs}
#'    \item{cov}{depth of coverage matrix of biallelic loci}
#'    \item{loglik}{log-likelihood of the fitting between observed and theoritical depth of coverage}
#'  }
#' @name mvCluster-class
#' @rdname mvCluster-class
#' @export
setClass("mvCluster",
         representation(name = "character",
                        eps = "numeric",
                        pts = "integer",
                        nvar = "integer",
                        pop = "character",
                        cov = "data.frame",
                        loglik = "numeric"),
         validity=function(object)
         {
           if( object@nvar != nrow(object@cov ) ){
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
