library(ggplot2)


d_f <- read.table("plotting_data.csv", sep="\t", header=TRUE)


ggplot(d_f, aes(x=col2, y=col1)) + 
    geom_boxplot(notch=TRUE)


ggsave("Normal_vs_tumor.pdf", dpi=600)
