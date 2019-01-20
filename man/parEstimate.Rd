\name{parEstimate}
\alias{parEstimate}
\title{parEstimate}
\description{
select the best parameters for density-based clustering}
\usage{
parEstimate(eps, pts, pref, crit = "loglik")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{eps}{epsilon values tested for density-based clustering}
  \item{pts}{minimum point values tested for density-based clustering}
  \item{pref}{runMetaVaR output directory}
  \item{crit}{the criterion to be used to select the best fitting of the depth of coverage, default is log-likelihood}
}

