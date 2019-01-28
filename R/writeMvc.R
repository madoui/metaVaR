#' writeMvc
#'
#' Write a \code{mvc} in an output directory
#'
#' @param x an object of class \code{mvc}.
#' @param prefix output directory
#'
#' @docType methods
#' @name  writeMvc
#' @rdname writeMvc-methods
#' @exportMethod writeMvc
#' @include mvc_class.R

setGeneric(
  name = "writeMvc",
  def = function(x,
                 prefix = "out"){
    standardGeneric("writeMvc")
  }
)

#' @rdname writeMvc-methods
#' @aliases writeMvc,mvc-method
setMethod(
  f = "writeMvc",
  signature = "mvc",
  definition = function(x,
                        prefix = "out"){

    dir.create(prefix, showWarnings = FALSE)
    mvcDir = paste (prefix,"/", x@name, sep = "")
    dir.create (mvcDir, showWarnings = FALSE)
    cat(paste(mvcDir,"\n"))
    write.table( x@cov,paste(mvcDir,"/coverage.txt", sep = ""), sep ="\t", quote = FALSE)
    fitFile = paste(mvcDir,"/loglik.txt", sep = "")
    write.table( t(c("pop","loglik")), fitFile, quote = F, col.names = FALSE, row.names = FALSE)
    mwisFile = paste(mvcDir, "/mwis.txt", sep = "")
    write.table( t(c("slot","value")), mwisFile, quote = F, col.names = FALSE, row.names = FALSE)
    for (pop in names(x@fit)){
      pdf(paste(mvcDir,"/",pop,"_fit.pdf", sep = ""), 6, 4)
      plot(x@fit[[pop]])
      dev.off()
      write.table (cbind (pop, x@fit[[pop]]$loglik),
                   paste(mvcDir,"/loglik.txt", sep = ""),
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
