import sys
import pandas as pd
import numpy as np

df = pd.read_csv(sys.stdin, header=None, sep="\t")
df.rename(columns={0: "Solid_Normal_Tissue", 1: "Tumor"}, inplace=True)


for col in df.columns:
    df[col] = np.log2(df[col] + 1)


df.fillna(0, inplace=True)


new_list1 = df["Solid_Normal_Tissue"].tolist()
new_list2 = df["Tumor"].tolist()


new_df1 = pd.DataFrame(new_list1, columns=["col1"])
new_df1["col2"] = "Solid_Normal_Tissue"

new_df2 = pd.DataFrame(new_list2, columns=["col1"])
new_df2["col2"] = "Tumor"


final_df = pd.concat([new_df1, new_df2], axis=0, ignore_index=True)
final_df.to_csv(sys.argv[1], sep="\t", header=True, index=False)
