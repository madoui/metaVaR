# metaVaR
Metavariant Species for Reference-free and Metagenomic-based Population Genomic Analysis
## Why using metaVaR?
Because it's cool baby!
## How to install metaVaR?
```
install_github("madoui/metaVaR")
```
## Ho to use metaVaR?
```
library(metaVaR)
data(MS5)
e = c(3,5)
p = c(5,10)
MVC = tryParam (MS5$cov, e, p)
MWIS = getMWIS (MVC)
MVS = mvc2mvs(MWIS)
```
