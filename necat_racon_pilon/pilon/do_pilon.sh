# pilon polish genome
# input: illumina data

species='TgVeg'
r1='../illumina/TgVEG_R1.fq.gz'
r2='../illumina/TgVEG_R2.fq.gz'

bwa index ../racon/racon3_${species}.fa                                                                              
bwa mem -t 20 ../racon/racon3_${species}.fa ${r1} ${r2} | samtools view -Sb > ${species}.bam
samtools sort -@ 30 -o ${species}.sorted.bam ${species}.bam
samtools index -@ 30 ${species}.sorted.bam
java -Xmx16G -jar picard.jar MarkDuplicates REMOVE_DUPLICATES= false MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=8000 INPUT=${species}.sorted.bam OUTPUT=${species}.sorted.markup.bam METRICS_FILE=${species}.sorted.markup.bam.metrics
samtools view -@ 30 -q 30 -b ${species}.sorted.markup.bam > ${species}.sorted.markup.filter.bam
samtools index -@ 30 ${species}.sorted.markup.filter.bam
java -Xmx16G -jar pilon-1.24.jar --genome ../racon/racon3_${species}.fa --frags ${species}.sorted.markup.filter.bam --fix snps,indels --output pilon1_${species}

bwa index pilon1_${species}.fasta                                                                              
bwa mem -t 20 pilon1_${species}.fasta ${r1} ${r2} | samtools view -Sb > pilon1_${species}.bam
samtools sort -@ 30 -o pilon1_${species}.sorted.bam pilon1_${species}.bam
samtools index -@ 30 pilon1_${species}.sorted.bam
java -Xmx16G -jar picard.jar MarkDuplicates REMOVE_DUPLICATES= false MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=8000 INPUT=pilon1_${species}.sorted.bam OUTPUT=pilon1_${species}.sorted.markup.bam METRICS_FILE=pilon1_${species}.sorted.markup.bam.metrics
samtools view -@ 30 -q 30 -b pilon1_${species}.sorted.markup.bam > pilon1_${species}.sorted.markup.filter.bam
samtools index -@ 30 pilon1_${species}.sorted.markup.filter.bam
java -Xmx16G -jar pilon-1.24.jar --genome pilon1_${species}.fasta --frags pilon1_${species}.sorted.markup.filter.bam --fix snps,indels --output pilon2_${species}

