import pandas as pd 

data1 = pd.read_excel("../dataset2.xlsx")

data2 = pd.read_excel("../dataset.xlsx", sheet_name=None)

print(data2)
