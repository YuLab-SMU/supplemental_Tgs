library(pafr)
library(colorspace)
library(gtrellis)
library(RColorBrewer)
library(circlize)
library(ComplexHeatmap)
library(ggplot2)
read.trf <- function(file) {
    x <- readLines(file)
    x <- x[grepl("^([0-9]|Sequence:)", x)]
    dat <- read.table(textConnection(x[grep("^[0-9]", x)]), sep = " ")
    dat <- dat[sapply(dat, is.numeric)]

    times <- diff(c(grep("Sequence:", x), length(x) + 1)) - 1
    seqinfo <- rep(x[grep("^Sequence:", x)], times)

    dat <- data.frame(Sequence = seqinfo, dat)
    colnames(dat) <- c("Seq_name","Seq_start","Seq_end","Seq_len","Copy_num",
                       "Consensus_size","Percent_matches","Percent_indels","Score",
                       "A","C","G","T","Entropy")
    return(dat)
}


bed1 <- read.table("TgGT1_chr.txt",head=T,sep='\t')
colnames(bed1) <- c("tname","start","end")

TgGT1 <- read_paf("../minimap2/TgGT1_asm_ref.paf")
TgGT1 <- TgGT1[grep("TgGT1",TgGT1$tname),]
TgGT1$tname <- factor(TgGT1$tname,levels = bed1$tname)
unique(TgGT1$tname)


gt1 <- read.trf(file = "../trf/TgGT1_assembly.fna.2.7.7.80.10.50.2000.dat")
gt1$Seq_name <- unlist(lapply(gt1$Seq_name,function(x){unlist(strsplit(x,split = " "))[2]}))
gt1 <- gt1[grep("TgGT1_",gt1$Seq_name),]
gt1 <- gt1[-grep("TgGT1_ChrApi",gt1$Seq_name),]
bed2 <- gt1[,c(1,2,3,5)]
colnames(bed2) <- c("chr","start","end","value")
unique(gt1$Seq_name)

chr_len <- bed1$end
names(chr_len) <- bed1$tname

gene_density <- genomicDensity(bed2,window.size = 10000,chr.len = chr_len,overlap = FALSE,count_by = "percent")
colnames(gene_density) <- c("tname","start","end","value")


gene <- read.table(file = "../pilon/TgGT1_chr/TgGT1_gene.gff", header = FALSE)
colnames(gene) <- c("tname","gene","start","end","geneid")
gene <- gene[grep("TgGT1_",gene$tname),]

p <- ggplot() + geom_rect(data=bed1,aes(xmin=start,xmax=end, ymin = -2, ymax = 0), fill = "#fcd217") +
    geom_rect(data=TgGT1,aes(xmin=tstart,xmax=tend, ymin = -2, ymax = 0), fill = "#3b818c") +
    geom_rect(data=gene_density,aes(xmin=start,xmax=end,ymin=0.1,ymax=2.1,fill=value)) +
    scale_fill_binned_sequential("SunsetDark") +
    scale_y_continuous(limits = c(-2.5,3)) +
    facet_wrap("tname",nrow = 13) +
    theme_bw() +
    xlab("Genomic Position") +
    theme(panel.grid = element_blank(),
          strip.background = element_blank(),
          strip.text = element_text(hjust = 0),
          axis.text.y = element_blank(),
          axis.ticks = element_blank(),
          panel.border = element_blank())


p2 <- ggplot() + geom_rect(data=bed1,aes(xmin=start,xmax=end), ymin = -2, ymax = 0, fill = "#fcd217") +
    geom_rect(data=TgGT1,aes(xmin=tstart,xmax=tend),ymin = -2, ymax = 0, fill = "#3b818c") +
    geom_rect(data=gene_density,aes(xmin=start,xmax=end,fill=value),ymin=0.5,ymax=2.5) +
    geom_rect(data=gene,aes(xmin=start,xmax=end),ymin = -4.1, ymax = -2.5,fill="#61ac85") +
    scale_fill_binned_sequential("SunsetDark") +
    scale_y_continuous(limits = c(-3.5,3)) +
    facet_wrap("tname",nrow = 13) +
    theme_bw() +
    xlab("Genomic Position") +
    theme(panel.grid = element_blank(),
          strip.background = element_blank(),
          strip.text = element_text(hjust = 0),
          axis.text.y = element_blank(),
          axis.ticks = element_blank(),
          panel.border = element_blank())

p

p2
