#!/bin/bash
# Set up job environment
module load SAMtools/1.9-GCC-8.2.0-2.31.1
module load R-bundle-Bioconductor/3.9-foss-2019a-R-3.6.0
PATH=$PATH:/cluster/projects/nn9313k/Andreas/Software/ScaR/bin/hisat2-2.1.0/
export PATH
PERL5LIB=/cluster/projects/nn9313k/Andreas/Software/ScaR_20200309/ScaR/lib/
export PERL5LIB

# Input decode file
decodefile="/cluster/projects/nn9313k/sadiya/SCAR/Scripts/1fusion_Temp.txt"

# Samples to loop over
Samples=("5a88da5b-1181-4232-be95-8ef86487fbd7" "c9be0c26-c2e5-4d44-a3f8-b9efd2f77562"
         "657482bc-c57e-4042-b688-2205434ae12f" "cd44a5fc-a723-4409-ae30-732ecf05ae1b "
         "711eca33-5ec2-45c3-9250-652581fa75ff" )

# Get column 1 and column 2 of decode file:
Fusion=$(awk -v var="$SLURM_ARRAY_TASK_ID" 'NR==var' $decodefile | awk '{print $1}')
Coordinate=$(awk -v var="$SLURM_ARRAY_TASK_ID" 'NR==var' $decodefile | awk '{print $2}')

# tmp split the two coordinates
coord1="$(cut -d'|' -f1 <<<"$Coordinate")"
coord2="$(cut -d'|' -f2 <<<"$Coordinate")"

# get the two gene-names
gene1="$(cut -d'-' -f1 <<<"$Fusion")"
gene2="$(cut -d'-' -f2 <<<"$Fusion")"

# get chromosomes and coordinates seperately, to make output folders
chr_gene1="$(cut -d':' -f1 <<<"$coord1")"
chr_gene2="$(cut -d':' -f1 <<<"$coord2")"

coordinate1="$(cut -d':' -f2 <<<"$coord1")"
coordinate2="$(cut -d':' -f2 <<<"$coord2")"

# Set input directory
inputdir="/cluster/projects/nn9313k/TCGA/PRAD_2020/Data_transfer/"

# Set output directory
outputdir="/cluster/projects/nn9313k/sadiya/SCAR/Results"

for Sample in "${Samples[@]}"
do

echo $Sample ${gene1}_${gene2} $Coordinate

# Check if directories exists - if not make them
[ -d ${outputdir}/${Sample} ] || mkdir ${outputdir}/${Sample}
[ -d ${outputdir}/${Sample}/${Fusion} ] || mkdir ${outputdir}/${Sample}/${Fusion}
[ -d ${outputdir}/${Sample}/${Fusion}/${chr_gene1}_${coordinate1}_${chr_gene2}_${coordinate2} ] || mkdir ${outputdir}/${Sample}/${Fusion}/${chr_gene1}_${coordinate1}_${chr_gene2}_${coordinate2}

# Execute SCAR:
perl /cluster/projects/nn9313k/Andreas/Software/ScaR_20200309/ScaR/select_read.pl \
        --first ${inputdir}/${Sample}/*1.fastq \
        --second ${inputdir}/${Sample}/*2.fastq \
        --geneA $gene1 --geneB $gene2 \
        --trimm 0 \
        --coordinate $Coordinate \
        --anno /cluster/projects/nn9313k/Andreas/Software/ScaR/reference/ \
        --output ${outputdir}/${Sample}/${Fusion}/${chr_gene1}_${coordinate1}_${chr_gene2}_${coordinate2}

done
