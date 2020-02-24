#' plotMvs
#'
#' plotMvs allows various plotting for \code{mvs} like depth of coverage and allele frequency distribution, pairwise F-statistics, LK distribution
#'
#' @param mvs an object of class \code{mvs}.
#' @param type type of plot to produce
#' @details
#' type can be "freq" for allele frequencies distribution,
#' "cov", for depth of coverage distribution.
#' "heatFst", for a heatmap of the pairwise F-statistics
#' "LK", for the global LK statistics
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
      Fst<-c();c<-NULL
      p = ggplot(data = fstTable, aes_(x=~Population1, y=~Population2, fill = ~Fst))+
        geom_tile(color = "white")+
        geom_text(aes(label = round(Fst, 2)))+
        scale_fill_gradient2(low = "white", high = "darkred", midpoint = 0, limit = c(0,1)) +
        theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                           panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
        coord_fixed()
      plot(p)
    }
    if ( type == "LK"){
      h = hist ( mvs@gLK$LK , plot = F, breaks = 50 )
      n_pop = ncol(mvs@freq)-1
      max1 = max ( h$density )
      max2 = max ( dchisq (seq(0:max(mvs@gLK$LK)), n_pop ))
      Max = max (max1, max2) + 0.1
      hist ( mvs@gLK$LK, freq = F, xlab = "LK" , ylim = c(0,Max) , breaks = 50 , main = "")
      x <- NULL; rm(x)
      curve ( dchisq( x, n_pop ) , lwd=3, col="orange" , add=T )
    }
  }
)
