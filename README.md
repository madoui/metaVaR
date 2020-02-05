# metaVar: MetaVariant Species (MVS) for reference-free and metagenomic-based population genomic analysis.
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
You first need to run DiscoSnp++ on multisample metagenomic data without references. Then, use the DiscoSnp++ VCF output to generate two matices: one depth of coverage matrix for bialleic loci and one allele frequency matrix. This task can be performed using the perl script metavarFilter.pl designed to parse the DiscoSnp++ output.
```
perl metavarFilter.pl -i metavariant.vcf -p prefix [-options...]
```

### Read/Write metaVaR outputs
```
# run metaVaR
e = c(3,5)
p = c(5,10)
MVC_list = tryParam (e, p, MS5$cov)

# store MVC
writeMvcList (MVC_list, "output_dir")

# import MVC
MVC_list = readMvcList ("output_dir")

MWIS_list = getMWIS (MVC_list)
MVS_list = mvc2mvs(MWIS_list, freq = MS5$freq)

# store MVS
writeMvsList (MVS_list, "output_dir")

# read MVS
MVS_list = readMvsList ("output_dir")
```

### Results visualisation
Four types of plot to produce on a MVS, here an example on the MVS 6_10_1.
```
# Plot the MVS distribution of allele frequency
plotMvs (MVS$`6_10_1`, type = "freq")

# Plot the MVS loci depth of coverage
plotMvs (MVS$`6_10_1`, type = "cov")

# Plot the pairwise $F_{ST}$ matrix
plotMvs (MVS$`6_10_1`, type = "heatFst")

# Plot the LK distribution
plotMvs (MVS$`6_10_1`, type = "LK")
```

### How to cite <i>metaVaR</i>?

metaVaR: introducing metavariant species models for reference-free metagenomic-based population genomics.
Romuald Laso-Jadart, Christophe Ambroise, Pierre Peterlongo, Mohammed-Amin Madoui. (2020)
bioRxiv 2020.01.30.924381; doi: https://doi.org/10.1101/2020.01.30.924381
