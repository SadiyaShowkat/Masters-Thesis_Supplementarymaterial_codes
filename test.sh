#!/bin/bash

module load SAMtools/1.9-GCC-8.2.0-2.31.1
module load R-bundle-Bioconductor/3.9-foss-2019a-R-3.6.0
PATH=$PATH:/cluster/projects/nn9313k/Andreas/Software/ScaR/bin/hisat2-2.1.0/
export PATH
PERL5LIB=/cluster/projects/nn9313k/Andreas/Software/ScaR_20200309/ScaR/lib/
export PERL5LIB

perl /cluster/projects/nn9313k/Andreas/Software/ScaR_20200309/ScaR/evaluate.pl \
--input /cluster/projects/nn9313k/sadiya/SCAR/Results/Restructured_Scarresults/ \
--output /cluster/projects/nn9313k/sadiya/SCAR/Evaluated_SCARresults/