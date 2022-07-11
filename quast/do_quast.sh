quast.py ../pilon/pilon2_TgGT1.fasta \
-r ../ref_genome/ToxoDB-56_TgondiiGT1_Genome.fasta \
-g ../ref_genome/ToxoDB-56_TgondiiGT1.gff \
-o pilon_TgGT1


quast.py ../pilon/pilon2_TgPru.fasta \
-r ../ref_genome/ToxoDB-56_TgondiiME49_Genome.fasta \
-g ../ref_genome/ToxoDB-56_TgondiiME49.gff \
-o pilon_TgPru

quast.py ../pilon/pilon2_TgVeg.fasta \
-r ../ref_genome/ToxoDB-56_TgondiiVEG_Genome.fasta \
-g ../ref_genome/ToxoDB-56_TgondiiVEG.gff \
-o pilon2_TgVeg
