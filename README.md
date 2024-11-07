# TCGA_analysis
This is a box plot code for a data set 
This is a practice code for snakemake application , a file contains the information for the folders containg data for normal and tumor tissue , we first extract the folder names then access the folders one by one which have a single tsv file , and from that for a particular gene name we take the value of tpm_unstranded and add it to its file, merge the two tumor and normal tissue files to make a sample sheet for ggplot2 

terminal codes:

snakemake --cores n --snakefile final_box_plot_code.smk plotting_data.csv

Rscript plot_code.r
