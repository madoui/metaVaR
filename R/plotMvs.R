#' plotMvs
#'
#' plotMvs allows various plotting for \code{mvs}
#'
#' @param mvs an object of class \code{mvs}.
#' @param type type of plot to produce
#' @details
#' type can be "freq" for allele frequencies distribution,
#' "cov", for depth of coverage distribution.
#' "heatFst", for a heatmap of the pairwise-Fst
#' "graphFst", for the "gFst"
#' @docType methods
#' @name  plotMvs
#' @rdname plotMvs-methods
#' @exportMethod plotMvs
#' @include mvs_class.R
#' @import ggplot2
#' @import reshape2

setGeneric(
  name = "plotMvs",
  def = function(mvs, type){
    standardGeneric("plotMvs")
  }
)

#' @rdname plotMvs-methods
#' @aliases plotMvs,mvs-method
setMethod(
  f = "plotMvs",
  signature = "mvs",
  definition = function(mvs, type){
    if ( type == "freq" ){
      boxplot(mvs@freq, las = 2)
    }
    if ( type == "cov"){
      boxplot (mvs@cov, las = 2)
    }
    if ( type == "heatFst"){
      get_lower_tri<-function(m){
        m[upper.tri(m)] <- NA
        return(m)
      }
      fstTable = data.frame( t(combn(names(get_lower_tri(mvs@pwFst)),2)), fst=t(mvs@pwFst)[lower.tri(mvs@pwFst)] )
      colnames(fstTable) = c("Population1", "Population2", "Fst")
      p = ggplot(data = fstTable, aes_(x=~Population1, y=~Population2, fill = ~Fst))+
        geom_tile(color = "white")+
        scale_fill_gradient2(low = "white", mid = "orange", high = "red",
                             midpoint = 0.5, limit = c(0,max(fstTable)), space = "Lab") +
        theme_minimal()+
        theme(axis.text.x = element_text(angle = 45, vjust = 1, size = 12, hjust = 1))+
        coord_fixed()
      plot(p)
    }
  }
)
