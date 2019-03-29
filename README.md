# metaVaR
MetaVariant Species for Reference-free and Metagenomic-based Population Genomic Analysis.
## Why using metaVaR?
<i>metaVaR</i> allows for rapid and robust population genomic analysis based on variants (called metavariants in this context) generated directly from metagenomic data without reference genomes or transcriptomes. Its utilization is based on <i>DiscoSnp++</i> ran on multisamples metagenomic reads. <i>metaVaR</i> clusters the metavariants into species called metavariant species or MVS by reference to metagenomic species. The genomic differentiation of the MVS is based on the analysis of the <i>F</i>-statistics. 
## How to install metaVaR?
<i>metaVaR</i> is a R package that can be installed using `install_github`.
```
install_github("madoui/metaVaR")
```
## How to use metaVaR?
```
library(metaVaR)
data(MS5)
e = c(3,5)
p = c(5,10)
MVC = tryParam (e, p, MS5$cov)
MWIS = getMWIS (MVC)
MVS = mvc2mvs(MWIS, freq = MS5$freq)
```
## How to use metaVaR?
```
library(metaVaR)
data(MS5)
e = c(3,5)
p = c(5,10)
MVC = tryParam (e, p, MS5$cov)
MWIS = getMWIS (MVC)
MVS = mvc2mvs(MWIS, freq = MS5$freq)
```
## metaVaR output
