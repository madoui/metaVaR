#' writeMvs
#'
#' Write a \code{mvs} in an output directory
#'
#' @param x an object of class \code{mvs}.
#' @param prefix output directory
#'
#' @docType methods
#' @name  writeMvs
#' @rdname writeMvs-methods
#' @exportMethod writeMvs
#' @include mvs_class.R

setGeneric(
  name = "writeMvs",
  def = function(x,
                 prefix = "out"){
    standardGeneric("writeMvs")
  }
)

#' @rdname writeMvs-methods
#' @aliases writeMvs,mvc-method
setMethod(
  f = "writeMvs",
  signature = "mvs",
  definition = function(x,
                        prefix = "out"){

    dir.create(prefix, showWarnings = FALSE)
    mvsDir = paste (prefix,"/", x@name, sep = "")
    dir.create (mvsDir, showWarnings = FALSE)
    cat(paste(mvsDir,"\n"))
    write.table( x@cov,paste(mvsDir,"/coverage.txt", sep = ""),
                 sep ="\t", quote = FALSE)
    write.table( x@freq,paste(mvsDir,"/frequencies.txt", sep = ""),
                 sep ="\t", quote = FALSE)
    write.table( x@pwFst,paste(mvsDir,"/pwFst.txt", sep = ""),
                 sep ="\t", quote = FALSE)
    write.table( x@gFst,paste(mvsDir,"/gFst.txt", sep = ""), sep ="\t",
                 quote = FALSE, col.names = FALSE, row.names = FALSE)
    write.table( x@gLK,paste(mvsDir,"/gLK.txt", sep = ""), sep ="\t",
                 quote = FALSE, col.names = FALSE, row.names = FALSE)
    fitFile = paste(mvsDir,"/loglik.txt", sep = "")
    write.table( t(c("pop","loglik")), fitFile, quote = F, col.names = FALSE, row.names = FALSE)
    mwisFile = paste(mvsDir, "/mwis.txt", sep = "")
    write.table( t(c("slot","value")), mwisFile, quote = F, col.names = FALSE, row.names = FALSE)
    for (pop in names(x@fit)){
      #pdf(paste(mvsDir,"/",pop,"_fit.pdf", sep = ""), 6, 4)
      #plot(x@fit[[pop]])
      #dev.off()
      write.table (cbind (pop, x@fit[[pop]]$loglik),
                   paste(mvsDir,"/loglik.txt", sep = ""),
                   row.names = F, col.names = F ,
                   quote = F, append = T)
    }
    write.table(rbind(c("connected_component",x@comp),
                      c("degree", x@deg),
                      c("weight", x@weight),
                      c("score", x@score),
                      c("mwis", x@mwis)),
                mwisFile,
                row.names = F, col.names = F ,
                quote = F, append = T)
  }
)
