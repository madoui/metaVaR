# metaVaR
MetaVariant Species for Reference-free and Metagenomic-based Population Genomic Analysis
## Why using metaVaR?
metaVaR allows for rapid and robust population genomic analysis based on variants (called metavariants in this context) generated directly from metagenomic data without use of reference genome. Its utilization is based on DiscoSNP++ ran on multisamples metagenomic reads. metaVaR clusters the metavariants in species called metavariant species or MVS by reference to metagenomic species (MGS). 
## How to install metaVaR?
metaVaR is a R package that can be installed
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
