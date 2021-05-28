#!/bin/bash


decodefile="/cluster/projects/nn9313k/sadiya/SCAR/Scripts/1fusion_Temp.txt"
Samples="/cluster/projects/nn9313k/sadiya/SCAR/Results_SDK1-AMACR/samples.txt"
outputdir="/cluster/projects/nn9313k/sadiya/SCAR/Results/Restructured_Scarresults/Restructured_Scarresults"

while read Sample
do

        mkdir ${outputdir}/${Sample}/

        while read line
        do

                Fusion=$(echo $line | awk '{print $1}')
                Coordinate=$(echo $line | awk '{print $2}')

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

                cp -r ${Sample}/${Fusion}/${chr_gene1}_${coordinate1}_${chr_gene2}_${coordinate2}/alt_*_0 ${outputdir}/${Sample}/${Fusion}_${chr_gene1}_${coordinate1}_${chr_gene2}_${coordinate2}

        done < $decodefile

done < $Samples

~
