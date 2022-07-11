input='TgPru'
input2='TgVeg'
asm1='../pilon/pilon2_TgPru.fasta'
asm2='../pilon/pilon2_TgVeg.fasta'
db='../softwares/busco_dataset/alveolata_odb10'

busco -i ${asm1} -l ${db} -o ${input}_pilon2_alveolata_busco -m genome
busco -i ${asm2} -l ${db} -o ${input2}_pilon2_alveolata_busco -m genome
