\name{viewPop}
\alias{viewPop}
\title{viewPop}
\description{Perform the analysis of a set of variants to detect genetic structure and natural selection}
\usage{viewPop(p)}
\arguments{
  \item{p}{a matrix of allele frequencies}
}
\details{
the matrix should contain variants in row and population in column
}
\value{plot (1) Allele frequencies distribution (2) fst-based Populations tree (3) Empirical and theoritical LK distribution

  \item{pw }{matrix of pairwise median Fst}
  \item{fst }{vector of global Fst}
  \item{LK }{vector of global LK}
  \item{selection}{data.frame of the selectionTest results}
}
\references{
%% ~put references to the literature/web site here ~
}

\note{
%%  ~~further notes~~
}


\seealso{pwFst, Fst, LK, plotLK, plotPW}
\examples{

}
