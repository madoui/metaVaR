# metaVaR
MetaVariant Species (MVS) for Reference-free and Metagenomic-based Population Genomic Analysis.
## Why using <i>metaVaR</i>?
<i>metaVaR</i> is R package developed for to perform robust population genomic analysis based on variants generated directly from metagenomic data without reference genomes or transcriptomes. Its utilization is based on the reference-free variant caller <a href="https://github.com/GATB/DiscoSnp"><i>DiscoSnp++</i></a> ran on multisamples metagenomic reads. <i>metaVaR</i> clusters the metavariants into species called metavariant species or MVS. <i>metaVaR</i> allows to estimate genomic differentiation through <i>F-statistics</i> and to identify loci under natural selection. 
## How to install metaVaR?
<i>metaVaR</i> is a R package that can be installed directly from github as follow:
```
install_github("madoui/metaVaR")
```
## How to use <i>metaVaR</i>?
### Data preprocessing and input dat format

### Quick running example on a toyset
Two toysets can be used with the package, the "6bac" dataset and the "MS5" dataset. The first dataset was created from simulated metagenomic data from bacterial genome admixture. The second toyset was created from real metagenomic data. Here is an example to run <i>metaVaR</i> on the "MS5" dataset.
```
library(metaVaR)
data(MS5)

# espilon parameter values to test for dbscan
e = c(3,5)
# minimum points parameter values to test for dbscan
p = c(5,10)

# Test dbscan parameters
MVC = tryParam (e, p, MS5$cov)

# Select maximum weigthed independant sets
MWIS = getMWIS (MVC)

# Filter loci for robust population genomic analysis
MVS = mvc2mvs(MWIS, freq = MS5$freq)
```
The results consists in a list of objects of class <i>mvs</i> that contains the allele frequency matrix, global and pairwise <i>F_{ST}</i>, LK and associated corrected p-value.

### metaVaR output format and results storage

### Results visualisation

### How to run <i>metaVaR</i> in parallel

### How to cite <i>metaVaR</i>
