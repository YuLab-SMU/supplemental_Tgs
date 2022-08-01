# minimap2
# intra-species asm-to-asm alignment
ref=' ../ref_genome/ToxoDB-56_TgondiiGT1_Genome.fasta'
asm1='../longread_genome/TgGT1_asm.fasta'
asm2='../pilon/pilon2_TgGT1.fasta'
minimap2 -cx asm5 ${asm1} ${ref} > aln1.paf 
minimap2 -cx asm5 ${asm2} ${ref} > aln2.paf

