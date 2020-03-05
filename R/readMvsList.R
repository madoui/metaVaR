#' readMvsList
#'
#' read \code{mvs} from a list of directory
#'
#' @param dir a directory.
#' @return a list of \code{mvs}
#'
#' @export

readMvsList<-function(dir = "") {

  MVS = list()
  list.dirs <- function(parent=".")   # recursively find directories
  {
    if (length(parent)>1)           # work on first and then rest
      return(c(list.dirs(parent[1]), list.dirs(parent[-1])))
    else {                          # length(parent) == 1
      if (!is.dir(parent))
        return(NULL)            # not a directory, don't return anything
      child <- list.files(parent, full.names = TRUE)
      if (!any(is.dir(child)))
        return(parent)          # no directories below, return parent
      else
        return(list.dirs(child))    # recurse
    }
  }

  is.dir <- function(x)    # helper function
  {
    ret <- file.info(x)$isdir
    ret[is.na(ret)] <- FALSE
    ret
  }
  mvsDirList = list.dirs(dir)
  for (mvsDir in mvsDirList){
    mvs = readMvs (mvsDir = mvsDir)
    MVS[[mvs@name]] = mvs
  }
  return (MVS)
}
