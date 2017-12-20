# Author: Ana Poets
# Description: Find BAPA_C names for SNPs in centromeres as shown in supp. table in Munoz et al 2011
####################################################################################

rm(list=ls())

# List of SNPs in centromeric region. Taken from supplemental table in Munoz et al 2011

CENTROMERE<-read.table("~/Documents/SmithLab/NAM/Data/Centromere_munoz2011/CentromerePositions.txt",header=T)

# Cross reference table between POPA (Munoz et al) and BOPA SNPs

Crossref<-read.table("~/Documents/SmithLab/NAM/Data/Centromere_munoz2011/NAME_refX_popaBOPA.txt", header = T)

# Vcf file with BOPA SNP position in new reference shared by Li Lei (sep , 2016)
VCF<-read.table("~/Documents/SmithLab/NAM/Data/BOPAsnp/bopa_test_LiLei.vcf")

# List of SNPs with single  hits in LiLei, other SNPs map to multiple places and we shoudn't use them
Uniq_list<-read.table("~/Documents/SmithLab/NAM/Data/BOPAsnp/List_SNP_uniqLiLei.txt")

# ========= First change centromere SNP names to BOPA names ==================
# find which SNPs have BOPA names
Shared<-intersect(CENTROMERE[,2], Crossref[,1]) #262/288 are present


Cen_sh<-CENTROMERE[(CENTROMERE[,2] %in% Shared),]
Crossref_sh<-Crossref[(Crossref[,1] %in% Shared),]

# order cross reff SNPs as in CENTROMERE
Crossref_sh_or <- Crossref_sh[match(Cen_sh[,2], Crossref_sh[,1]),]

# Add bopa names

if (identical(as.character(Crossref_sh_or[,1]), as.character(Cen_sh[,2])) == FALSE)stop("Error! Cross reference names and Centromeric SNPs are in different order")

Cetromere_bopa<-cbind(Cen_sh, Crossref_sh_or[,2] )
names(Cetromere_bopa)[4]<-"BOPA"


# ========= Second, find position of BOPA SNPs in the new genome reference ===============================================

VCF_uniq<-VCF[(VCF[,3] %in% Uniq_list[,1]),]

VCF_centromere<-VCF_uniq[(VCF_uniq[,3] %in% Cetromere_bopa[,4]),] #216/262 are present 

# Sort VCF_centromere by chromosome and then by position
## combine chromosome and SNP position 
VCF_centromere$SNPname<-paste(VCF_centromere[,1],"_", VCF_centromere[,2],sep="")
#order by position alphanumeric
library(gtools)

VCF_centromere_SNPor<-mixedsort(VCF_centromere$SNPname)

VCF_centromere_or<-VCF_centromere[match(VCF_centromere_SNPor, VCF_centromere[,9]),]

write.table(VCF_centromere_or,"~/Documents/SmithLab/NAM/Data/Centromere_munoz2011/CentromeresInNewRef.txt",quote=F,row.names=F,col.names=F, sep="\t")
