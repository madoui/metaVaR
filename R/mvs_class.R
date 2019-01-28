#' Class mvs
#'
#' Class \code{mvs} defines a metavariants species.
#'
#' @section Slots:
#' \describe{
#'    \item{id}{mvs id.}
#'    \item{freq}{allele frequencies}
#'    \item{gFst}{global Fst}
#'    \item{gLK}{global LK}
#'    \item{pwFst}{pairwise-fst}
#'
#'  }
#' @include mvc_class.R
#' @name mvs-class
#' @rdname mvs-class
#' @exportClass mvs
#' @author momosapiens
setClass(Class = "mvs",
         representation = representation(id = "character",
                                         freq = "data.frame",
                                         gFst = "numeric",
                                         gLK = "numeric",
                                         pwFst = "data.frame"),
         prototype = list(
           id = "",
           freq = data.frame(),
           gFst = 0,
           gLK = 0,
           pwFst = data.frame()),

         contains = "mvc",
         validity=function(object)
         {
           if (is.na(object@id)){
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
