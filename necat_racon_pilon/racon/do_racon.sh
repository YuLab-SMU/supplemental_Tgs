# racon 
# longread genome polishment
# input: raw read; paf generated from minimap2 (mapped read to assembly); assembly fasta

# First polish
reads='../nanopore_read/YF0198_TgVeg.fastq'
asm='../necat_genome/TgVeg_polished.fasta'
paf='../minimap2/necat_TgVeg_polished.paf'
species='TgVeg'
racon -t 30 ${reads} ${paf} ${asm} > racon1_${species}.fa

# Second polish
minimap2 -d racon1_${species}.mmi racon1_${species}.fa
minimap2 -t 20 -x map-ont racon1_${species}.mmi ${reads} > racon1_${species}.paf
racon -t 30 ${reads} racon1_${species}.paf racon1_${species}.fa > racon2_${species}.fa

# Third polish

minimap2 -d racon2_${species}.mmi racon2_${species}.fa
minimap2 -t 20 -x map-ont racon2_${species}.mmi ${reads} > racon2_${species}.paf
racon -t 30 ${reads} racon2_${species}.paf racon2_${species}.fa > racon3_${species}.fa






