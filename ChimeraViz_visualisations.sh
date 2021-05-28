#Chimera Viz 

#Always go to the last directory of  R ( cd /cluster/home/sadiyashowkat/R/x86_64-pc-linux-gnu-library/3.6/biovizBase/libs)

#module load R/3.6.0-intel-2019a
#"R"
#Load the library

library(chimeraviz)
# 1. Reference to results file

#Importing Data 
SF  <- read.delim("/cluster/projects/nn9313k/sadiya/STAR-Fusion/Results/d363816a-d8de-40ff-8a02-d2aeefa94e09/star-fusion.fusion_predictions.tsv")
SF2<- read.delim("/cluster/projects/nn9313k/sadiya/STAR-Fusion/Results/711eca33-5ec2-45c3-9250-652581fa75ff/star-fusion.fusion_predictions.tsv")
SF3 <- read.delim("/cluster/projects/nn9313k/sadiya/STAR-Fusion/Results/9d9d3d55-9a57-47bd-8791-54f3b793fc31/star-fusion.fusion_predictions.tsv")

#Making fusion object

fusions <- import_starfusion("/cluster/projects/nn9313k/sadiya/STAR-Fusion/Results/9d9d3d55-9a57-47bd-8791-54f3b793fc31
/star-fusion.fusion_predictions.tsv","hg38")

fusions <- import_starfusion("/cluster/projects/nn9313k/sadiya/STAR-Fusion/Results/sample/star-fusion.fusion_predictions.tsv","hg38")

fusions <- import_starfusion("/cluster/projects/nn9313k/sadiya/STAR-Fusion/Results/sample/star-fusion.fusion_predictions.tsv","hg38")


# To determine the entries 
length(fusions)
[1] 81

#Grabbing up the 2nd entry with TMPRSS2-ERG fusion
fusion <- get_fusion_by_id(fusions, 2) 
[1] "Fusion object"
[1] "id: 2"
[1] "Fusion tool: starfusion"
[1] "Genome version: hg38"
[1] "Gene names: TMPRSS2-ERG"
[1] "Chromosomes: 21-21"
[1] "Strands: -,-"
[1] "In-frame?: NA"

#Upstream Partner
upstream_partner_gene(fusion)
[1] "PartnerGene object"
[1] "Name: TMPRSS2"
[1] "ensemblId: ENST00000332149"
[1] "Chromosome: 21"
[1] "Strand: -"
[1] "Breakpoint: 41508081"


#downstream_partner_gene(fusion)
[1] "PartnerGene object"
[1] "Name: ERG"
[1] "ensemblId: ENST0000044244"
[1] "Chromosome: 21"
[1] "Strand: -"
[1] "Breakpoint: 38445621"

#Creating the Database for ENSEMBLE
edb <- ensembldb::EnsDb("Homo_sapiens.GRCh38.89.sqlite")

#creating plot_fusion (An event for the fusion) 
pdf(file="d36_T2ERG_plot.pdf", width = 16, height = 9)
plot_fusion(fusion = fusion, edb = edb, non_ucsc=T)
dev.off()

# to create a transcript plot for a specific fusion.#TMPRSS-ERG #sample 711
fusion <- get_fusion_by_id(fusions, 4)
edb <- ensembldb::EnsDb("Homo_sapiens.GRCh38.89.sqlite")
pdf(file="711_T2ERG_plot_transcript.pdf", width = 16, height = 9)
plot_transcripts(fusion=fusion , edb=edb ,non_ucsc=T)

#Creating a condensed plot for the fusion transcript #sample -711 , fusion event 4
edb <- ensembldb::EnsDb("Homo_sapiens.GRCh38.89.sqlite")
pdf(file="711_T2ERG_plot_fusion_transcript.pdf", width = 16, height = 9)
plot_fusion_transcript(fusion = fusion , edb=edb)
dev.off()

#Creating Graph 
#same as above 
pdf(file="711_T2ERG_plot_fusion_transcript_graphplot.pdf", width = 16, height = 9)








