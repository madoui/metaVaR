\name{checkClusters}
\alias{checkClusters}
\title{checkClusters}
\description{Analysis of the dbscan clusters to identify sets of variants corresponding to single species.}
\usage{checkClusters( Cov, cl, pref, minCov, minVar, minPop )}

\arguments{
  \item{Cov}{matrix of loci coverage}
  \item{cl}{dbscan output list}
  \item{pref}{output directory prefix, default is "checkCL_out"}
  \item{minCov}{minimum median coverage of loci from the same cluster, default is 8}
  \item{minVar}{minimum amount of variants to consider a cluster, default is 1000}
  \item{minPop}{minimum amount of variants to consider a cluster, default is 4}
}
\details{
checkCL creates a list of dbscan valid clusters.
}
\value{
  \item{varID}{variant IDs}
  \item{pop}{population IDs where the variants are present}
  \item{cov}{variant loci coverage}
}
\references{
%% ~put references to the literature/web site here ~
}

\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{

}

