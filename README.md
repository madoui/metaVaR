# <i>metaVar</i>: MetaVariant Species (MVS) for reference-free and metagenomic-based population genomic analysis.
## Why using <i>metaVaR</i>?
<i>metaVaR</i> is R package developed for to perform robust population genomic analysis based on variants generated directly from metagenomic data without reference genomes or transcriptomes. Its utilization is based on the reference-free variant caller <a href="https://github.com/GATB/DiscoSnp"><i>DiscoSnp++</i></a> ran on multisamples metagenomic reads. <i>metaVaR</i> clusters the metavariants into species called metavariant species or MVS. <i>metaVaR</i> allows to estimate genomic differentiation through <i>F-statistics</i> and to identify loci under natural selection. 
## How to install <i>metaVaR</i>?
<i>metaVaR</i> is a R package that can be installed directly from github as follow:
```
install_github("madoui/metaVaR")
```
## How to use <i>metaVaR</i>?
### Quick running example on a toyset
Two toysets can be used with the package, the "6bac" dataset and the "MS5" dataset. The first dataset was created from simulated metagenomic data from bacterial genome admixture. The second toyset was created from real metagenomic data. Here is an example to run <i>metaVaR</i> on the "MS5" dataset.
```
library(metaVaR)

# espilon values to test for dbscan
e = c(3,5)
# minimum points values to test for dbscan
p = c(5,10)

# Test all dbscan parameter couples
MVC = tryParam (e, p, MS5$cov)

# Select maximum weigthed independant sets
MWIS = getMWIS (MVC)

# Filter loci to generate MVS
MVS = mvc2mvs(MWIS, freq = MS5$freq)
```
The results consists in a list of objects of class <i>mvs</i> that contains the allele frequency matrix, global and pairwise <i>F_{ST}</i>, LK and associated corrected p-value.

### Data preprocessing and input data format
You first need to run DiscoSnp++ on multisample metagenomic data without references. Then, use the DiscoSnp++ VCF output to generate two matices: one depth of coverage matrix for bialleic loci and one allele frequency matrix. This task can be performed using the perl script metavarFilter.pl.
```
perl metavarFilter.pl -i metavariant.vcf -p prefix -m
```

### metaVaR output format and results storage
```
library(metaVaR)

# run metaVaR
e = c(3,5)
p = c(5,10)
MVC = tryParam (e, p, MS5$cov)
MWIS = getMWIS (MVC)
MVS = mvc2mvs(MWIS, freq = MS5$freq)

# store results

```

### Results visualisation

### How to run <i>metaVaR</i> in parallel?

### How to cite <i>metaVaR</i>?
