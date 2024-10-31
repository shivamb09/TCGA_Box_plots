import pandas as pd

import numpy as np

import glob

import os

configfile: "config.yaml"

tumor_files = [l.strip() for l in open("metadata/normal_files_list.txt")]

normal_files = [line.strip() for line in open("metadata/tumor_files_list.txt")]

rule tumor generator:
	input:
		file_list = config["files_info"]["tumor_file"]

	output:
		"tumor_data.tsv"
	run:
		for files in input.file_list:
			directory = str(files)
			pattern = "*.augmented_star_gene_counts.tsv"
			file_list = glob.glob(os.path.join(directory,pattern))
			df = pd.read_csv(file_list[0],sep="\t",comment="#")
			df = df.loc[df["gene_name"] == "NKX2-1",:]
			final_data = df["tpm_unstranded"]
		with open(output,"a") as l:
			for values in final_data["tpm_unstranded"]:
				l.write(f"{values}\n"
			
rule normal_generator:
	input:
		file_list = config["files_info"]["normal_file"]
	output:
		"normal_data.tsv"
	run:
		for files in input.file_list:
			directory = str(files)
			pattern = "*.augmented_star_gene_counts.tsv"
			file_list = glob.glob(os.path.join(directory.pattern)
			df = pd.read_csv(file_list[0],sep="\t",comment="#")
			df = pd.loc[df["gene_name"] == "NKX2-1",:]
			final_data = df["tpm_unstranded"]
		with open(output,"a") as l:
			for values in final_dict["tmp_unstranded"]:
				l.write(f"{values}\n")

rule file_merger:
	input:
		file1:"normal_data.tsv",
		file2:"tumor_data.tsv"
	output:
		"plotting_data.csv"
	shell:
		"paste {input.file1} {input.file2} |python3 table_generator.py {output}"

rule plot_generator:
	input:
		"plotting_data.csv"
	output:
		"box_plot_normal_vs_tumor.pdf"
	shell:
	 "cat {input}|Rscript plot_code.r {output}"
		
