# metaVaR
Metavariant Species for Reference-free and Metagenomic-based Population Genomic Analysis
## Why using metaVaR?
Because it's cool baby!
## How to install metaVaR?
```
install_github("madoui/metaVaR")
```
## How to use metaVaR?
```
library(metaVaR)
data(MS5)
e = c(3,5)
p = c(5,10)
MVC = tryParam ( e, p, MS5$cov)
MWIS = getMWIS (MVC)
MVS = mvc2mvs(MWIS, minPop = 3, minCov = 8, MS5$freq)
```
