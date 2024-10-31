import pandas as pd
import glob
import os

configfile: "config.yaml"


tumor_files = [line.strip() for line in open("metadata/tumor_files_list.txt")]
normal_files = [line.strip() for line in open("metadata/normal_files_list.txt")]


rule tumor_generator:
    input:
        file_list=config["files_info"]["tumor_file"]
    output:
        "tumor_data.tsv"
    run:
        with open(output[0], "w") as l:
            for directory in tumor_files:
                pattern = "*.augmented_star_gene_counts.tsv"
                file_list = glob.glob(os.path.join(directory, pattern))
                if not file_list:
                    continue  
                df = pd.read_csv(file_list[0], sep="\t", comment="#")
                df = df.loc[df["gene_name"] == "NKX2-1", :]
                final_data = df["tpm_unstranded"]
                for value in final_data:
                    l.write(f"{value}\n")

rule normal_generator:
    input:
        file_list=config["files_info"]["normal_file"]
    output:
        "normal_data.tsv"
    run:
        with open(output[0], "w") as l:
            for directory in normal_files:
                pattern = "*.augmented_star_gene_counts.tsv"
                file_list = glob.glob(os.path.join(directory, pattern))
                if not file_list:
                    continue  
                df = pd.read_csv(file_list[0], sep="\t", comment="#")
                df = df.loc[df["gene_name"] == "NKX2-1", :]
                final_data = df["tpm_unstranded"]
                for value in final_data:
                    l.write(f"{value}\n")


rule file_merger:
    input:
        file1="normal_data.tsv",
        file2="tumor_data.tsv"
    output:
        "plotting_data.csv"
    shell:
        "paste {input.file1} {input.file2} | python3 table_generator.py {output}"


