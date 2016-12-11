###BOPA SNP
`sorted_all_BOPA_masked_95idt.vcf`: This file stores all of the BOPA SNPs mapped back to the Morex reference version1.
It includes 3039 SNPs out of 3071 contexture sequences because we can not figure out the rest of 32  SNPs either due to the deletetion in reference or the SNPs not located in the matched region when we blast the contexture sequence against the masked Morex reference genome V1.

Here are the steps I did to figure out the physical position for those SNPs:

- run SNP_Utils from https://github.com/mojaveazure/SNP_Utils
```bash
 makeblastdb -in 160404_barley_pseudomolecules_masked.fasta -dbtype nucl -parse_seqids

 ./snp_utils.py  CONFIG -d 160404_barley_pseudomolecules_masked.fasta -k -i 95 -c blast_masked_idt95

./snp_utils.py BLAST -l BOPA_lookup.txt -c blast_masked_idt95 -b -m envirass/2013_iSelect_Genetic_Map.map -d -t 100000 -o BOPA_masked_95idt#.vcf
```

- After I ran SNP_Utils, we can get 2975 SNPs without duplicates, and 21 SNPs with duplicates, 70 failed due to either no hits (could be 95 identity if still higher), the SNP position in reference is deleteion or the only a small fraction of the contexture sequence hit the genome and SNPs are not in the hit region.

for those SNPs with duplicates and failed ones, we mannually blast with IPK server: http://webblast.ipk-gatersleben.de/barley_ibsc/blastresult.php?jobid=147976517327&opt=none

For duplicates, I firstly search which gene this SNP located with SNP meta: http://conservancy.umn.edu/bitstream/handle/11299/181367/Barley_SNP_Annotations.txt?sequence=5&isAllowed=y
Then blast the gene against the masked reference genome and figured out the correct one. If I can not find the gene that SNP hit or the gene blast have multiple identical results, we just choose the left position and write the notes in the last field of the vcf files.

###9k SNP
`sorted_all_9k_masked_90idt.vcf`: This file stores all of the 9k SNPs mapped back to the Morex reference version1.
It includes 7757 SNPs out of 7864 contexture sequences because we can not figure out the rest of 107 SNPs either due to the deletetion in reference or the SNPs not located in the matched region when we blast the contexture sequence against the masked Morex reference genome V1.
Here are the steps I did to figure out the physical position for those SNPs:
- run SNP_Utils from https://github.com/mojaveazure/SNP_Utils
```bash
./snp_utils.py CONFIG -d 160404_barley_pseudomolecules_masked.fasta -i 90 -e 0.000001 -s 350 -k -c blast_masked_idt90

./snp_utils.py BLAST -l 9k_iSelect_Lookup.tsv -c blast_masked_idt90 -b -m envirass/2013_iSelect_Genetic_Map.map -d -t 100000 -o 9k_masked_90idt
```
- After I ran SNP_Utils, we can get 7439 SNPs without duplicates, and 240 SNPs with duplicates, 166 failed due to either no hits (could be 90 identity if still higher), the SNP position in reference is deleteion or the only a small fraction of the contexture sequence hit the genome and SNPs are not in the hit region.

for those SNPs with duplicates and failed ones, we mannually blast with IPK server: http://webblast.ipk-gatersleben.de/barley_ibsc/blastresult.php?jobid=147976517327&opt=none

For duplicates, I firstly search which gene this SNP located with SNP meta: http://conservancy.umn.edu/bitstream/handle/11299/181367/Barley_SNP_Annotations.txt?sequence=5&isAllowed=y
Then blast the gene against the masked reference genome and figured out the correct one. If I can not find the gene that SNP hit or the gene blast have multiple identical results, we just choose the left position and write the notes in the last field of the vcf files.
