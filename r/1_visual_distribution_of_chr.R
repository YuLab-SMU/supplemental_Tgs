# histogram
library(dplyr)
library(ggplot2)
library(colorspace)
rm(list = ls())

dat <- read.table(file = "./Genome_hist.txt",header = TRUE)
head(dat)
str(dat)

lel <- c("ChrIa","ChrIb","ChrII","ChrIII","ChrIV","ChrV","ChrVI",
         "ChrVIIa","ChrVIII","ChrIX","ChrX","ChrXI","ChrXII")

gen <- c("TgGT1-assembly","TgRH88-reference","ToxoDB-TGGT1","TgPRU-assembly","TgME49-reference",
         "ToxoDB-TGME49","TGVEG-assembly","TgCTG-reference","ToxoDB-TGVEG")
dat$chr <- factor(dat$chr,levels = lel)
dat$genome <- factor(dat$genome,levels = gen)

p <- ggplot(dat,aes(x=genome_group,y= size,fill=genome)) +
    geom_bar(position="stack",stat="identity",color="white",size=0.5) +
    #geom_bar(position="stack",stat="identity") +
    scale_fill_discrete_qualitative("Set2") +
    theme_bw() +
    facet_grid(group~chr,switch = "x") +
    guides(fill=guide_legend(title="Genome")) +
    geom_hline(yintercept = 0,size=0.1) +
    theme(panel.grid = element_blank(),
          axis.text.x = element_blank(),
          axis.ticks.x = element_blank(),
          axis.ticks.y = element_line(size=0.1),
          axis.line.y = element_line(color="black",size=0.1),
          panel.border = element_blank(),
          strip.background = element_blank(),
          # strip.placement = "outside",
          axis.title.y = element_text(family = 'Times',face = 'bold',size=12), # for pdf
          strip.text = element_text(family = 'Times',face = 'bold',size=10),
          legend.text = element_text(family = 'Times',size=8),
          legend.title = element_text(family = 'Times',size=10),
          axis.text.y = element_text(size=8),
          title = element_text(family = 'Times',face = 'bold',size=12),
          legend.key.size = unit(0.2, "inches"),
          panel.spacing = unit(0, "mm")
    ) +
    xlab("") +
    ylab("Chromosome size")


pdf("./plot/Chr_Histogram.pdf",width = 10,height = 8)
p

dev.off()

# tiff("./plot/Chr_Histogram.tiff",width = 1600,height = 1200, res = 300, units = "px",compression = "lzw")
# p
#
# dev.off()
