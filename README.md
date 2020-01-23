# metaVaR
MetaVariant Species (MVS) for Reference-free and Metagenomic-based Population Genomic Analysis.
## Why using metaVaR?
<i>metaVaR</i> is developed rapid and robust population genomic analysis based on variants (called metavariants in this context) generated directly from metagenomic data without reference genomes or transcriptomes. Its utilization is based on <a href="https://github.com/GATB/DiscoSnp"><i>DiscoSnp++</i></a> ran on multisamples metagenomic reads. <i>metaVaR</i> clusters the metavariants into species called metavariant species or MVS. The MVSs genomic differentiation can be estimaed based on <i>F</i>-statistics. 
## How to install metaVaR?
<i>metaVaR</i> is a R package that can be installed as follow:
```
install_github("madoui/metaVaR")
```
## How to run metaVaR?
Two toysets can be used with the package, the "6bac" dataset and the "MS5" dataset. The first dataset was created from simulated data and the second from real metagenomic data. Here is an example to run <i>metaVaR</i> on the the "MS5" dataset
```
library(metaVaR)
data(MS5)
e = c(3,5)
p = c(5,10)
MVC = tryParam (e, p, MS5$cov)
writeMvcList(MVC, "MVC")
MWIS = getMWIS (MVC)
writeMvcList(MWIS, "MWIS")
MVS = mvc2mvs(MWIS, freq = MS5$freq)
writeMvcList(MVS, "MVS")
```
The results consists in a list of objects of class <i>mvs</i> that contains the allele frequency matrix and can be used for population genomics analysis.

## metaVaR outputs
