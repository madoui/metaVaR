#' plotMvs
#'
#' plotMvs allows various plotting of a \code{mvs}
#'
#' @param x an object of class \code{mvs}.
#' @param t type of plot to produce, can "freq", "cov", "heatFst", "graphFst", "gFst"
#'
#' @docType methods
#' @name  plotMvs
#' @rdname plotMvs-methods
#' @exportMethod writeMvs
#' @include mvs_class.R
#' @import ggplot2
#' @import reshape2

setGeneric(
  name = "plotMvs",
  def = function(x,t){
    standardGeneric("plotMvs")
  }
)

#' @rdname plotMvs-methods
#' @aliases plotMvs,mvs-method
setMethod(
  f = "plotMvs",
  signature = "mvs",
  definition = function(x, t){
    if ( t == "freq" ){
      boxplot(x@freq, las = 2)
    }
    if ( t == "cov"){
      boxplot (x@cov, las = 2)
    }
    if ( t == "heatFst"){
      get_lower_tri<-function(m){
        m[upper.tri(m)] <- NA
        return(m)
      }
      fstTable = data.frame( t(combn(names(x@pwFst),2)), fst=t(x@pwFst)[lower.tri(x@pwFst)] )
      colnames(fstTable) = c("Population1", "Population2", "Fst")
      p = ggplot(data = fstTable, aes("Population1", "Population2", fill = Fst))+
        geom_tile(color = "white")+
        scale_fill_gradient2(low = "blue", high = "orange", mid = "red",
                             midpoint = 0.5, limit = c(0,1), space = "Lab") +
        theme_minimal()+
        theme(axis.text.x = element_text(angle = 45, vjust = 1, size = 12, hjust = 1))+
        coord_fixed()
      plot(p)
    }
  }
)
